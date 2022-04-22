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
        coffeeAmountInput.typeText(String(amount))
    }

}
