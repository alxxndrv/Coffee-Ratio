//
//  TimerAndButtonsView.swift
//  RatiosUITests
//
//  Created by Georgy Alexandrov on 30.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import Foundation
import XCTest


class TimerAndButtonsView {
    
    let app: XCUIApplication
    let startButton: XCUIElement
    let resetButton: XCUIElement
    let timerView: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.startButton = app.buttons.matching(identifier: "timerActionButton").firstMatch
        self.resetButton = app.buttons.matching(identifier: "resetButton").firstMatch
        self.timerView = app.staticTexts.matching(identifier: "timerView").firstMatch
    }
    
    func startTimer() {
        self.startButton.tap()
    }
    
    func resetTimer() {
        self.resetButton.tap()
    }
    
}
