//
//  RatioInputView.swift
//  RatiosUITests
//
//  Created by Georgy Alexandrov on 22.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import Foundation
import XCTest

class RatioInputView {
    
    let app: XCUIApplication
    let ratioInputView: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.ratioInputView = app.textFields.matching(identifier: "waterAmountTextField").firstMatch
    }
    
    
    // TODO: refactor into a protocol or smthng
    func enterRatio(ratio: Int, hideKeyboard: Bool = true, deletePrevious: Bool = true) {
        if deletePrevious {
            self.ratioInputView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
            self.ratioInputView.clearText()
        } else {
            self.ratioInputView.tap()
        }
        ratioInputView.typeText(String(ratio))
        guard hideKeyboard == true else { return }
        app.keyboards.buttons["Return"].tap()
    }

}

