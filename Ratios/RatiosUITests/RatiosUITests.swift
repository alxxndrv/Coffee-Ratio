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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    
    /// # Testing the calculations
    /// _Well, the stress-testing part isn't use-case at all (1.000.000 coffee cups), but IDK if we should test it
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
        
        /// Stress-testing
        /// Uncomment to test random huge values
//        let testValues = (1...10).map({ _ in ((1 * 1_000)...(1 * 1_000_000)).randomElement()! })
//
//        for coffeeAmount in testValues {
//            coffeeInput.enterCoffeeAmount(amount: coffeeAmount)
//            let ratio = coffeeAmount / (2...10).randomElement()!
//            ratioInput.enterRatio(ratio: ratio)
//
//            let neededValue: UInt64 = UInt64(ratio * coffeeAmount)
//            let waterAmount = Float(waterAmountText.label)?.rounded() ?? 0
//
//            print("Testing with coffee: \(coffeeAmount), ratio: \(ratio) and should get \(neededValue).\nOutput: \(waterAmount)")
//            XCTAssertEqual(UInt64(waterAmount), neededValue)
//        }
//
    }
    
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
}


extension XCUIDevice {
    func sendAppToBackground(sleepInterval: Int? = nil, app: XCUIApplication? = nil) {
        self.press(XCUIDevice.Button.home)
        guard (sleepInterval != nil && app != nil) else { return }
        sleep(UInt32(sleepInterval!))
        app!.activate()
    }
}
