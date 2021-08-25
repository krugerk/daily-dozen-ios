//
//  UITestsScroll.swift
//  DailyDozenUITests
//
//  Copyright © 2021 Nutritionfacts.org. All rights reserved.
//

import XCTest

// See: https://stackoverflow.com/questions/32891466/uitesting-xcode-7-how-to-tell-if-xcuielement-is-visible

struct UITestsScroll {
    
    var app: XCUIApplication!
    
    func elementIsWithinWindow(element: XCUIElement) -> Bool {
        guard element.exists && !element.frame.isEmpty && element.isHittable 
        else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(element.frame)
    }
    
    func scrollWindowFromBottonToTop(times: Int = 1) {
        let mainWindow = app.windows.firstMatch
        let topScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.05))
        let bottomScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.90))
        for _ in 0..<times {
            bottomScreenPoint.press(forDuration: 0, thenDragTo: topScreenPoint)
        }
    }

    func scrollWindowFromTopToBottomUp(times: Int = 1) {
        let mainWindow = app.windows.firstMatch
        let topScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.05))
        let bottomScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.90))
        for _ in 0..<times {
            topScreenPoint.press(forDuration: 0, thenDragTo: bottomScreenPoint)
        }
    }  
    
    func scrollUntilElementAppears(element: XCUIElement, threshold: Int = 10) {
        var iteration = 0
        
        while !elementIsWithinWindow(element: element) {
            guard iteration < threshold else { break }
            scrollWindowFromBottonToTop()
            iteration += 1
        }
        
        if !elementIsWithinWindow(element: element) { 
            scrollWindowFromBottonToTop(times: threshold)
        }
        
        while !elementIsWithinWindow(element: element) {
            guard iteration > 0 else { break }
            scrollWindowFromTopToBottomUp()
            iteration -= 1
        }
    }
    
}
