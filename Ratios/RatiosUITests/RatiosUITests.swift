//
//  RatiosUITests.swift
//  RatiosUITests
//
//  Created by John Peden on 2/26/20.
//  Copyright © 2020 John Peden. All rights reserved.
//

import XCTest

class RatiosUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    
    /// # Testing the calculations
    /// Just checking up that calculation function is working
    func testCoffeeAmountInput() {
        let app = XCUIApplication()
        
        app.launch()
        
        let waterAmountText = app.staticTexts.matching(identifier: "waterAmountText").firstMatch
        
        let coffeeInput = CoffeeInputView(app: app)
        coffeeInput.enterCoffeeAmount(amount: 1)
        
        let ratioInput = RatioInputView(app: app)
        ratioInput.enterRatio(ratio: 1)
        
        let basicWaterAmount = Float(waterAmountText.label)?.rounded() ?? 0
        
        XCTAssertEqual(basicWaterAmount, 1, "Wrong amount of water with data equals 1, 1")
                
        /// Max values test
        coffeeInput.enterCoffeeAmount(amount: 10000, hideKeyboard: false)
        XCTAssertEqual(coffeeInput.coffeeAmountInput.value as? String ?? "", "1000", "App allows to increase coffee value over 1000")
                
        XCTAssertTrue(app.staticTexts["wrongCoffeeAmount"].exists, "Warning of wrong coffee amount doesn't pop up")
        
        coffeeInput.enterCoffeeAmount(amount: 9999, hideKeyboard: false)
        XCTAssertEqual(coffeeInput.coffeeAmountInput.label, "999", "App allows to increase coffee value over 1000")
        XCTAssertTrue(app.staticTexts["wrongCoffeeAmount"].exists, "Warning of wrong coffee amount doesn't pop up")
        
        
    }
    
    /// # Testing inputs visibility
    /// Due to guidelines, it's important to keep textfields and main views of the app visible even if the keyboard is opened.
    func testInputsVisibility() {
        let app = XCUIApplication()
        app.launch()
        
        let timerView = TimerAndButtonsView(app: app)
        let coffeeInput = CoffeeInputView(app: app)
        let ratioInput = RatioInputView(app: app)
        
        // Checking whether the inputs are visible or not
        XCTAssertTrue(coffeeInput.coffeeAmountInput.checkInputVisibility(), "Coffee input isn't visible after pressing on the textfield")
        XCTAssertTrue(timerView.timerView.isVisible, "Timer view isn't visible while using coffee amount input")
        XCTAssertTrue(ratioInput.ratioInputView.checkInputVisibility(), "Ratio input isn't visible after pressing on the textfield")
        XCTAssertTrue(timerView.timerView.isVisible, "Timer view isn't visible while using ratio input")

    }
    
    
    /// # Testing keyboard types
    /// Guidelines says that it's important to show keyboard with appropriate type in specific textfields. In our ratio and coffee amount input the numeric keyboard should be used.
    /// As far as I know, XCUITest doesn't allow to check the type directly, so we use a little `костыль` (checking whether the keyboard does have `return` button or not) here.
    func testKeyboardTypes() {
        let app = XCUIApplication()
        app.launch()
        
        let coffeeInput = CoffeeInputView(app: app)
        let ratioInput = RatioInputView(app: app)
        
        // Checking whether the inputs are numeric or not
        coffeeInput.enterCoffeeAmount(amount: 1, hideKeyboard: false)
        XCTAssertTrue(app.isCurrentKeyboardNumeric, "Non-numeric keyboard assigned to coffee input")
        ratioInput.enterRatio(ratio: 1, hideKeyboard: false)
        XCTAssertTrue(app.isCurrentKeyboardNumeric, "Non-numeric keyboard assigned to ratio input")
    }
    
    
    /// # Testing timer buttons
    /// Checking the normal behaviour of the timer.
    /// It should start on the tap of a button, continue counting in the background, and then auto-stop & reset on tap of a reset button
    func testTimerButtons() {
        let app = XCUIApplication()
        app.launch()
        
        let timerView = TimerAndButtonsView(app: app)
        timerView.startTimer()
        sleep(1)
        // Send app to background
        XCUIDevice.shared.sendAppToBackground(sleepInterval: 1, app: app)
        
        // Asserting that timer goes correctly even in the background
        XCTAssertEqual(timerView.timerView.label, "00:02", "Wrong timer value: \(timerView.timerView.label) instead of 00:02")
        
        timerView.resetTimer()
        XCTAssertEqual(timerView.timerView.label, "00:00", "Timer isn't resetted even after pressing the button")
        

        
    }
    
    
    func stressTestCalculations() {
        let app = XCUIApplication()
        app.launch()
        let waterAmountText = app.staticTexts.matching(identifier: "waterAmountText").firstMatch
        let coffeeInput = CoffeeInputView(app: app)
        let ratioInput = RatioInputView(app: app)
        let testValues = (1...10).map({ _ in ((1 * 1_000)...(1 * 1_000_000)).randomElement()! })
        for coffeeAmount in testValues {
            coffeeInput.enterCoffeeAmount(amount: coffeeAmount)
            let ratio = coffeeAmount / (2...10).randomElement()!
            ratioInput.enterRatio(ratio: ratio)

            let neededValue: UInt64 = UInt64(ratio * coffeeAmount)
            let waterAmount = Float(waterAmountText.label)?.rounded() ?? 0

            print("Testing with coffee: \(coffeeAmount), ratio: \(ratio) and should get \(neededValue).\nOutput: \(waterAmount)")
            XCTAssertEqual(UInt64(waterAmount), neededValue)
        }
    }
    
}


extension XCUIDevice {
    func sendAppToBackground(sleepInterval: Int? = nil, app: XCUIApplication? = nil) {
        self.press(XCUIDevice.Button.home)
        guard (sleepInterval != nil && app != nil) else { return }
        sleep(UInt32(sleepInterval!))
        app!.activate()
    }
}
