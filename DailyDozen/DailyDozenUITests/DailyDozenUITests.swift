//
//  DailyDozenUITests.swift
//  DailyDozenUITests
//
//  Copyright © 2019 Nutritionfacts.org. All rights reserved.
//
// swiftlint:disable type_body_length

import XCTest

class DailyDozenUITests: XCTestCase {
    // all tests
    let helper = UITestsHelper.shared
    let dozeList = ["dozeBeans", "dozeBerries", "dozeFruitsOther", "dozeVegetablesCruciferous", "dozeGreens", "dozeVegetablesOther", "dozeFlaxseeds", "dozeNuts", "dozeSpices", "dozeWholeGrains", "dozeBeverages", "dozeExercise", "otherVitaminB12"]
    let tweakList = ["tweakMealWater", "tweakMealNegCal", "tweakMealVinegar", "tweakMealUndistracted", "tweakMeal20Minutes", "tweakDailyBlackCumin", "tweakDailyGarlic", "tweakDailyGinger", "tweakDailyNutriYeast", "tweakDailyCumin", "tweakDailyGreenTea", "tweakDailyHydrate", "tweakDailyDeflourDiet", "tweakDailyFrontLoad", "tweakDailyTimeRestrict", "tweakExerciseTiming", "tweakWeightTwice", "tweakCompleteIntentions", "tweakNightlyFast", "tweakNightlySleep", "tweakNightlyTrendelenbrug"]
    let infoList = ["info_item_videos_access", "info_item_how_not_to_die_access", "info_item_how_not_to_die_cookbook_access", "info_item_how_not_to_diet_access", "info_item_challenge_access", "info_item_donate_access", "info_item_subscribe_access", "info_item_open_source_access", "info_item_about_access"]
    let scrollPage = ["A", "B", "C", "D", "E"]
    // each test
    var app: XCUIApplication!

    /// Called before each test method invocation
    override func setUp() {        
        continueAfterFailure = false
        app = XCUIApplication()
        
        //app.launchArguments = [
        //        "-inUITest",
        //        "-AppleLanguages",
        //        "(pl)",
        //        "-AppleLocale",
        //        "pl_PL"
        //    ]
        
        app.launch()
    }

    /// Called after each test method invocation
    override func tearDown() { /* not used */ }
    
    func testAppScreens() {
        // showUITestsHelperInof()
        
        //snapDozeEntry()
        //snapTweakEntry()
        snapInfoMenu()
        snapPrefs()
        //snapUtilities()
    }

    func testSnapDozeEntryDetail() {
        let url = helper.dirTopic("DozenEntry")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_doze_access"].tap()
                
        // ----- Table Element Only -----
        
        //let tables: XCUIElementQuery = app.tables
        //screenshot = tables.firstMatch.screenshot()
        //helper.writeScreenshot(screenshot, dir: url, name: "DozeEntryTables")
        
        // ----- One Example Calendar Page -----
        
        // ----- More Info Pages -----
        
        var cellElement: XCUIElement!
        var pageIdx = 0
        for item in dozeList {
            let id = "\(item)_access"
            cellElement = app.cells.matching(identifier: id).element
            
            if cellElement.exists == false || cellElement.isHittable == false {
                // Screenshot: Doze Entry Screen
                let snap = app.screenshot()
                let name = "DozeEntry_\(scrollPage[pageIdx])"
                helper.writeScreenshot(snap, dir: url, name: name)
                scrollOneSetUp()
                pageIdx += 1
            }

            // go to more info page
            cellElement.buttons
                .matching(identifier: "doze_entry_info_access")
                .element
                .tap()
            scrollSnapAll(topic: item, max: 3) 
            
            // return to main entry page
            app.navigationBars.firstMatch
                .buttons.firstMatch
                .tap()            
        }
    }
    
    func testSnapDozeEntryOLD() {
        let url = helper.dirTopic("DozenEntry")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_doze_access"].tap()
                
        // ----- Table Element Only -----
        
        //let tables: XCUIElementQuery = app.tables
        //screenshot = tables.firstMatch.screenshot()
        //helper.writeScreenshot(screenshot, dir: url, name: "DozeEntryTables")
        
        // ----- One Example Calendar Page -----
        
        // ----- More Info Pages -----
        
        var cellElement: XCUIElement!
        var pageIdx = 0
        for item in dozeList {
            let id = "\(item)_access"
            cellElement = app.cells.matching(identifier: id).element
            
            if cellElement.exists == false || cellElement.isHittable == false {
                // Screenshot: Doze Entry Screen
                let snap = app.screenshot()
                let name = "DozeEntry_\(scrollPage[pageIdx])"
                helper.writeScreenshot(snap, dir: url, name: name)
                scrollWindowFromBottonToTop()
                pageIdx += 1
            }
                        
            print("•• window frame \(app.windows.firstMatch.frame)")
            print("•• cell frame \(cellElement.frame)")
            cellElement.buttons
                .matching(identifier: "doze_entry_info_access")
                .element
                .tap()
            print("•• window frame \(app.windows.firstMatch.frame)")            
            showAccessHierarchary(withFrames: true)
            scrollAndSnapshot(name: item, url: url) 
            print(":DEBUG:")
            
            app.navigationBars.firstMatch
                .buttons.firstMatch
                .tap()
            
            print(":DEBUG:")
        }
                        
        print(":DEBUG:")
    }

    func snapDozeEntryElements() {
        let url = helper.dirTopic("DozenEntry")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_doze_access"].tap()
        
        // :NYI: scroll to top
                
        var cellElement: XCUIElement!
        for item in dozeList {
            let id = "\(item)_access"
            cellElement = app.cells.matching(identifier: id).element
            while !cellElement.exists {
                app.swipeUp()
            }
            let screenshot = cellElement.screenshot()
            helper.writeScreenshot(screenshot, dir: url, name: item)
        }
                        
        print(":DEBUG:")
    }
    
    // :WIP: stops at tweakDailyGinger_access not found
    func testSnapTweakEntryDetail() {
        let url = helper.dirTopic("TweakEntry")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_tweaks_access"].tap()
                
        // ----- Table Element Only -----
        
        //let tables: XCUIElementQuery = app.tables
        //screenshot = tables.firstMatch.screenshot()
        //helper.writeScreenshot(screenshot, dir: url, name: "TweakEntryTables")
        
        // ----- One Example Calendar Page -----
        
        // ----- More Info Pages -----
        
        var cellElement: XCUIElement!
        var pageIdx = 0
        for item in tweakList {
            let id = "\(item)_access"
            cellElement = app.cells.matching(identifier: id).element
            
            if cellElement.exists == false || cellElement.isHittable == false {
                // Screenshot: Tweak Entry Screen
                let snap = app.screenshot()
                let name = "TweakEntry_\(scrollPage[pageIdx])"
                helper.writeScreenshot(snap, dir: url, name: name)
                scrollOneSetUp()
                pageIdx += 1
            }

            // go to more info page
            cellElement.buttons
                .matching(identifier: "tweak_entry_info_access")
                .element
                .tap()
            scrollSnapAll(topic: item, max: 2) 
            
            // return to main entry page
            app.navigationBars.firstMatch
                .buttons.firstMatch
                .tap()            
        }
    }
    
    func snapTweakEntry() {
        let url = helper.dirTopic("TweakEntry")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_tweak_access"].tap()

        // Screenshot: Tweak Screen
        let screenshot: XCUIScreenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "TweakEntry")
    }

    func snapInfoMenu() {
        let url = helper.dirTopic("InfoMenu")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_info_access"].tap()

        // Screenshot: Info Screen
        scrollAndSnapshot(name: "InfoMenu", url: url)       
    }

    func snapPrefs() {
        let url = helper.dirTopic("Preferences")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_preferences_access"].tap()

        // Screenshot: Preferences Screen
        var screenshot: XCUIScreenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "Preferences")

        app.cells.matching(identifier: "reminder_cell_access").element.tap()
        
        guard
            app.switches
                .matching(identifier: "reminder_settings_enable_access")
                .element.waitForExistence(timeout: 5.0)
        else {
            showAccessHierarchary()
            fatalError("reminder_settings_enable_access does not exist")
        }
        
        // Screenshot: Utilities Screen
        screenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "Reminder")
    }

    func snapUtilities() {
        let url = helper.dirTopic("Utilities")
        let navtabBar: XCUIElement = app.tabBars["navtab_access"]
        navtabBar.buttons["navtab_preferences_access"].tap()

        app.buttons.matching(identifier: "setting_util_advanced_access").element.tap()
        
        guard
            app.buttons
                .matching(identifier: "util_db_btn_export_access")
                .element.waitForExistence(timeout: 5.0)
        else {
            showAccessHierarchary()
            fatalError("util_db_btn_export_access does not exist")
        }
        
        // Screenshot: Utilities Screen
        let screenshot: XCUIScreenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "Utilities")
    }
    
    // MARK: - Input Actions

    func toggleDozeCheckbox(row: XCUIElement, boundedBy: Int) {
        row.children(matching: .button)
            .matching(identifier: "doze_entry_checkbox_access")
            .element(boundBy: boundedBy).tap()
    }
    
    // MARK: - Scroll Actions
    
    func isLastCellHittable() -> Bool {
        let cellList = app.cells.allElementsBoundByIndex
        if let lastCell = cellList.last {
            return lastCell.isHittable
        }
        fatalError("isLastCellHittable() cells not found")
    }
    
    /// returns page count
    @discardableResult
    func scrollAndSnapshot(name: String, url: URL) -> Int {
        var pageIdx = 0
        var screenshot: XCUIScreenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "\(name)_\(pageIdx)")
        while isLastCellHittable() == false {
            pageIdx += 1
            scrollWindowFromBottonToTop()
            screenshot = app.screenshot()
            helper.writeScreenshot(screenshot, dir: url, name: "\(name)_\(pageIdx)")
        }
        return pageIdx + 1 // page count
    }

    /// returns page count
    @discardableResult
    func scrollAndSnapshotCells(name: String, url: URL) -> Int {
        var pageIdx = 0
        var screenshot: XCUIScreenshot = app.screenshot()
        helper.writeScreenshot(screenshot, dir: url, name: "\(name)_\(pageIdx)")
        while isLastCellHittable() == false {
            pageIdx += 1
            scrollWindowFromBottonToTop()
            screenshot = app.screenshot()
            helper.writeScreenshot(screenshot, dir: url, name: "\(name)_\(pageIdx)")
        }
        return pageIdx + 1 // page count
    }
    
    func scrollSnapAll(topic: String, max: Int = 10) {
        let url = helper.dirTopic(topic)
        var count = 0
        
        let snap = app.screenshot()
        let name = "\(topic)@\(count)"
        helper.writeScreenshot(snap, dir: url, name: name)
        
        while scrollOneSetUp() {
            count += 1
            if count >= max { return }

            let snap = app.screenshot()
            let name = "\(topic)@\(count)"
            helper.writeScreenshot(snap, dir: url, name: name)
        }
    }
    
    @discardableResult
    func scrollOneSetUp() -> Bool {
        let cellList: [XCUIElement] = app.cells.allElementsBoundByIndex
        var firstCell: XCUIElement! = nil
        var lastCell: XCUIElement! = nil                
        
        if let endCell = cellList.last, endCell.isHittable {
             return false // no more to scroll
        }
        
        // find first and last hittable cell
        for idx in cellList.startIndex ..< cellList.endIndex {
            let cell = cellList[idx]
            if cell.isHittable {
                if firstCell == nil {
                    firstCell = cell
                } else {
                    lastCell = cell
                }
            }
        }
        
        if firstCell == nil || lastCell == nil {
            return false
        }
        
        let midpoint = CGVector(dx: 0.5, dy: 0.5)
        let firstCoord = firstCell.coordinate(withNormalizedOffset: midpoint)
        let lastCoord = lastCell.coordinate(withNormalizedOffset: midpoint)
        lastCoord.press(
            forDuration: 0.1,        // seconds 
            thenDragTo: firstCoord, 
            withVelocity: .slow,     // XCUIGestureVelocity(pixels_per_sec)  
            thenHoldForDuration: 0.1 // seconds
        )
        return true
    }
    
    func scrollWindowFromBottonToTop(times: Int = 1) {
        let mainWindow: XCUIElement = app.windows.firstMatch
        let topScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.05))
        let bottomScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.90))
        for _ in 0 ..< times {
            //bottomScreenPoint.press(forDuration: 0, thenDragTo: topScreenPoint)
            bottomScreenPoint.press(forDuration: 0, thenDragTo: topScreenPoint, withVelocity: XCUIGestureVelocity.slow, thenHoldForDuration: 0.1)
        }
    }
    
    func scrollWindowFromTopToBottomUp(times: Int = 1) {
        let mainWindow = app.windows.firstMatch
        let topScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.05))
        let bottomScreenPoint = mainWindow
            .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.90))
        for _ in 0 ..< times {
            topScreenPoint.press(forDuration: 0, thenDragTo: bottomScreenPoint)
        }
    }  
    
    // MARK: - Show Information
        
    // 
    func showAccessHierarchary(withFrames: Bool = false) {
        // accessibility hierarchy snapshot
        var str = app.debugDescription

        if withFrames == false {
            // {{origin: left-upper}, {size: width-height}
            // {{0.0, 0.0}, {320.0, 568.0}}
            let regex = "\\{\\{.*\\}\\}"
            str = str.replacingOccurrences(of: regex, with: "", options: .regularExpression)
        }
        
        str = str.replacingOccurrences(of: "\\n", with: "\n")
        //             0x600003f5a840
        let regex = ", 0x[a-f0-9]+,"
        str = str.replacingOccurrences(of: regex, with: "", options: .regularExpression)
        str = str.replacingOccurrences(of: " ,", with: ",", options: .regularExpression)
        print("::APP ACCESSIBILITY HIERARCHY::\n\(str)")
    }
    
    func showCellListStatus() {
        //           cell[0] exists
        var str = "•••••\ncell[N]:exists:frame:hittable: identifier\n"
        let cellList = app.cells.allElementsBoundByIndex
        for idx in 0 ..< cellList.count {
            let cell = cellList[idx]
            let exists = cell.exists ? "T" : "f"
            let frame = !cell.frame.isEmpty ? "T" : "f"
            let hittable = cell.isHittable ? "T" : "f"
            str.append("cell[\(idx)] \(exists) \(frame) \(hittable) \(cell.identifier)\n")
        }
        print("\n\(str)\n")
    }
    
    func showUITestsHelperInfo() {
        print(helper.infoAppLaunchEnvironment)
        print(helper.infoDevice)
        print(helper.infoLocale)
        print(helper.infoLocaleIdentifier)
        print(helper.infoProcessArguments)
        print(helper.infoProcessEnvironment)
        // print(helper.dirTopic("HelperTestTopicA"))
        // print(helper.dirTopic("HelperTestTopicB"))
    }

}

// :NYI: doze.backBtn.access --> doze_backBtn_access

// --- Screenshot providers
// let screenshot = app.screenshot() // current device screen
// let xcuiScreen: XCUIScreen = XCUIScreen.main
// let screenshot = xcuiScreen.screenshot()
// let xcuiScreenList: [XCUIScreen] = XCUIScreen.windows
// let mainWindow: XCUIElement = XCUIApplication().windows.firstMatch
// let screenshot mainWindow.screenshot()
// let screenshot = app.screenshot() // current device screen
// 

// :NYI: first launch
//app.alerts["“DailyDozen” Would Like to Send You Notifications"].scrollViews.otherElements.buttons["Allow"].tap()
//app/*@START_MENU_TOKEN@*/.staticTexts["Codzienny Tuzin + 21 Adaptacji"]/*[[".buttons[\"Codzienny Tuzin + 21 Adaptacji\"].staticTexts[\"Codzienny Tuzin + 21 Adaptacji\"]",".staticTexts[\"Codzienny Tuzin + 21 Adaptacji\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

//let tablesQuery = app.tables
//tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Turn All Categories Off"]/*[[".cells.staticTexts[\"Turn All Categories Off\"]",".staticTexts[\"Turn All Categories Off\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//app.navigationBars["Health Access"].buttons["Allow"].tap()
