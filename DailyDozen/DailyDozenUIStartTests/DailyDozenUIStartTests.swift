//
//  DailyDozenUIStartTests.swift
//  DailyDozenUIStartTests
//
//  Copyright © 2021 Nutritionfacts.org. All rights reserved.
//

import XCTest

class DailyDozenUIStartTests: XCTestCase {
    
    var count = 0

    override func setUpWithError() throws {
        print("::: SETUP \(count)")
        printBundleInfo()
        printDeviceInfo()
        printLocaleInfo()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        // handler: (XCUIElement) -> Bool
        let token = addUIInterruptionMonitor(
            withDescription: "example interruption monitor") { 
            // Code block handles asynchronous UI interruptions e.g. alerts
            // where XCUIElement represents the top level UI element for an alert.
            (element: XCUIElement) in
            print("\(element.debugDescription)")
            // return true if UI element *was* handled
            // return false if UI element *was*not* handled
            return true
        }
        print("setup token: \(token.debugDescription ?? "nil")")
    }

    override func tearDownWithError() throws {
        print("::: TEARDOW \(count)")
        count += 1
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample3Monitor() throws {
        print("::: testExample3Monitor")
        
        let app = XCUIApplication()
        
        // handler: (XCUIElement) -> Bool
        let token = addUIInterruptionMonitor(
            withDescription: "example interruption monitor") { 
            // Code block handles asynchronous UI interruptions e.g. alerts
            // where XCUIElement represents the top level UI element for an alert.
            (element: XCUIElement) in
            print("\(element.debugDescription)")
            // return true if UI element *was* handled
            // return false if UI element *was*not* handled
            return true
        }
        print("monitor token: \(token.debugDescription ?? "nil")")
        
        app.launch()
        sleep(15)
        print(":::")
    }
    
    func testExample2Springboard() throws {
        print("::: testExample2Springboard")
        let app = XCUIApplication()
        app.launch()

        // Setup springboard
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        var springboardHelper = ScrollHelper()
        springboardHelper.setApp(springboard)
        
        //
        let index01 = 1
        let secondButton = springboard.buttons.element(boundBy: index01)
        if secondButton.waitForExistence(timeout: 15) {
            springboardHelper.printAccessTree()
            secondButton.tap()
        }
                
    }
    
    func testExample1() throws {
        print("::: testExample1")
        // Setup application
        let app = XCUIApplication()

        // Setup springboard
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        var springboardHelper = ScrollHelper()
        springboardHelper.setApp(springboard)
        
        // Run application
        app.launch()
        //
        let index01 = 1
        let secondButton = springboard.buttons.element(boundBy: index01)
        if secondButton.waitForExistence(timeout: 15) {
            springboardHelper.printAccessTree()
            secondButton.tap()
        }
    }
    
    // MARK: - Process Management
    
    func printBundleInfo() {
        print("PRODUCT_BUNDLE_IDENTIFIER = \(Bundle.main.bundleIdentifier ?? "not found")")
    }
    
    func printDeviceInfo() {
        let device = UIDevice.current
        //let uiIdiom = device.userInterfaceIdiom // phone, pad, tv, mac
        print("""
        DEVICE:
                     model = \(device.model)
                      name = \(device.name)
                systemName = \(device.systemName)
             systemVersion = \(device.systemVersion)
        
        """)
    }
    
    func printLocaleInfo() {
        let currentLocale = Locale.current
        print("""
        LOCALE:
          decimalSeparator = \(currentLocale.decimalSeparator ?? "nil")

                identifier = \(currentLocale.identifier)
              languageCode = \(currentLocale.languageCode ?? "nil")
                regionCode = \(currentLocale.regionCode ?? "nil")
                scriptCode = \(currentLocale.scriptCode ?? "nil")
               variantCode = \(currentLocale.variantCode ?? "nil")

                  calendar = \(currentLocale.calendar)
          usesMetricSystem = \(currentLocale.usesMetricSystem)
        
        """)
    }

}
