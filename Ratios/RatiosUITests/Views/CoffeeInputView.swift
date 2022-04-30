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
    
    func enterCoffeeAmount(amount: Int) {
        coffeeAmountInput.tap()
        coffeeAmountInput.typeText(String(amount))
        app.keyboards.buttons["return"].tap()
    }
    
    func checkInputVisibility() -> Bool {
        coffeeAmountInput.tap()
        coffeeAmountInput.typeText("test")
        return coffeeAmountInput.exists && coffeeAmountInput.isHittable
    }

}
