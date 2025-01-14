//
//  CoffeeInputView.swift
//  RatiosUITests
//
//  Created by Georgy Alexandrov on 21.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import XCTest
import Foundation

class CoffeeInputView {
    
    let app: XCUIApplication
    let coffeeAmountInput: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.coffeeAmountInput = app.textFields.matching(identifier: "coffeeAmountTextField").firstMatch
    }
    
    func enterCoffeeAmount(amount: Int, hideKeyboard: Bool = true, deletePrevious: Bool = true) {
        
        if deletePrevious {
            self.coffeeAmountInput.tap(withNumberOfTaps: 2, numberOfTouches: 1)
            self.coffeeAmountInput.clearText()
        } else {
            self.coffeeAmountInput.tap()
        }
        
        coffeeAmountInput.typeText(String(amount))
        guard hideKeyboard else { return }
        app.keyboards.buttons["Return"].tap()
    }

}


extension XCUIElement {
    /// Checking whether the TextField is visible or not
    /// (it's required by Apple to be visible)
    /// https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/keyboards/#:~:text=use%20the%20keyboard%20layout%20guide%20to%20make%20the%20keyboard%20feel%20like%20an%20integrated%20part%20of%20your%20interface
    func checkInputVisibility() -> Bool {
        self.tap()
        self.typeText("test")
        return self.isVisible
    }
    
    var isVisible: Bool {
        return self.exists && self.isHittable
    }
    
    func checkKeyboardHideability() {
        
    }
    
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}

extension XCUIApplication {
    var isCurrentKeyboardNumeric: Bool {
        return !self.keyboards.buttons["return"].isHittable
    }
}
