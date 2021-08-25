//
//  MiscUITests.swift
//  DailyDozenUITests
//
//  Copyright © 2021 Nutritionfacts.org. All rights reserved.
//
// swiftlint:disable function_body_length

import XCTest

class MiscUITests: XCTestCase {
    // all tests
    let helper = UITestsHelper.shared
    // each test
    var app: XCUIApplication!
    
    /// Called before each test method invocation
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    /// Called after each test method invocation
    override func tearDownWithError() throws { /* not used */ }

    func testWindowCoordinates() {
        var s = "\nWINDOW\n"
        let mainWindow: XCUIElement = app.windows.firstMatch

        let frame: CGRect = mainWindow.frame
        s.append("mainWindow.frame\n")
        s.append("       origin = \(frame.origin)\n")
        s.append("         size = \(frame.size)\n")
        s.append("   left-upper = (\(frame.minX), \(frame.minY))\n")
        s.append("     midpoint = (\(frame.midX), \(frame.midY))\n")
        s.append("  right-lower = (\(frame.maxX), \(frame.maxY))\n")

        s.append("----- 00 -----\n")

        let cgVector00 = CGVector(dx: 0.0, dy: 0.0)
        let coord00 = mainWindow.coordinate(withNormalizedOffset: cgVector00)
        s.append("coor00 \(coord00.debugDescription)\n")
        let cgPointAa = coord00.screenPoint
        s.append("gcPointAa \(cgPointAa)\n")
        
        let cgVector55 = CGVector(dx: 0.5, dy: 0.5)
        let coordBb = coord00.withOffset(cgVector55)
        let cgPointBb = coordBb.screenPoint
        s.append("cgPointBb \(cgPointBb) … additive offset 0.5\n")

        let cgVector2020 = CGVector(dx: 20, dy: 20)
        let coordCc = coord00.withOffset(cgVector2020)
        let cgPointCc = coordCc.screenPoint
        s.append("cgPointCc \(cgPointCc) … additive offset 20\n")
        
        s.append("----- mid ----\n")
        
        let cgVectorMid = CGVector(dx: 0.5, dy: 0.5)
        let coordMidAa = mainWindow.coordinate(withNormalizedOffset: cgVectorMid)
        s.append("coordMidAa \(coordMidAa.debugDescription)\n")
        let gcPointMidAa = coordMidAa.screenPoint
        s.append("gcPointMidAd \(gcPointMidAa)\n")
        
        let coordMidBb = coordMidAa.withOffset(cgVectorMid)
        let cgPointMidBb = coordMidBb.screenPoint
        s.append("cgPointMidBb \(cgPointMidBb) … additive offset 0.5\n")

        let coordMidCc = coordMidAa.withOffset(cgVector2020)
        let cgPointMidCc = coordMidCc.screenPoint
        s.append("cgPointMidCc \(cgPointMidCc) … additive offset 20\n")

        s.append("----- beyond ----\n")

        let cgVectorBeyond = CGVector(dx: 2.0, dy: 2.0)
        let coordBeyondAa = mainWindow.coordinate(withNormalizedOffset: cgVectorBeyond)
        s.append("coordBeyondAa \(coordBeyondAa.debugDescription)\n")
        let gcPointBeyondAa = coordBeyondAa.screenPoint
        s.append("gcPointBeyondAd \(gcPointBeyondAa)\n")
        
        let coordBeyondBb = coordBeyondAa.withOffset(cgVector55)
        let cgPointBeyondBb = coordBeyondBb.screenPoint
        s.append("cgPointBeyondBb \(cgPointBeyondBb) … additive offset 0.5\n")

        let coordBeyondCc = coordBeyondAa.withOffset(cgVector2020)
        let cgPointBeyondCc = coordBeyondCc.screenPoint
        s.append("cgPointBeyondCc \(cgPointBeyondCc) … additive offset 20\n")

        print(s)        
    }
    
    func testCellCoordinates() {
        var s = "\nCELL\n"
        let cell: XCUIElement = app.cells.firstMatch
        
        let frame: CGRect = cell.frame
        s.append("cell.frame\n")
        s.append("       origin = \(frame.origin)\n")
        s.append("         size = \(frame.size)\n")
        s.append("   left-upper = (\(frame.minX), \(frame.minY))\n")
        s.append("     midpoint = (\(frame.midX), \(frame.midY))\n")
        s.append("  right-lower = (\(frame.maxX), \(frame.maxY))\n")

        s.append("----- normal 0.5 ----\n")
        let cgVectorMid = CGVector(dx: 0.5, dy: 0.5)
        let coordMidAa = cell.coordinate(withNormalizedOffset: cgVectorMid)
        s.append("coordMidAa \(coordMidAa.debugDescription)\n")
        let gcPointMidAa = coordMidAa.screenPoint
        s.append("gcPointMidAd \(gcPointMidAa)\n")
        
        let addOffset06 = CGVector(dx: 0.6, dy: 0.6)
        let coordMidBb = coordMidAa.withOffset(addOffset06)
        let cgPointMidBb = coordMidBb.screenPoint
        s.append("cgPointMidBb \(cgPointMidBb) … additive offset 0.6\n")

        let addOffset20 = CGVector(dx: 20, dy: 20)
        let coordMidCc = coordMidAa.withOffset(addOffset20)
        let cgPointMidCc = coordMidCc.screenPoint
        s.append("cgPointMidCc \(cgPointMidCc) … additive offset 20\n")

        print(s)
    }
    
    func testMoveOneCell() {
        let cell: XCUIElement = app.cells.firstMatch

        print(cell.debugDescription)
    }

    func testMoveNHittableSets() {
        moveNHittableSets()
    }

    func moveNHittableSets(max: Int = 10) {
        let url = helper.dirTopic("moveNHittableSets")
        var count = 0
        
        let snap = app.screenshot()
        let name = "TestMoveN_count@\(count)"
        helper.writeScreenshot(snap, dir: url, name: name)
        
        while testMoveOneHittableSet() {
            count += 1
            let snap = app.screenshot()
            let name = "TestMoveN_count@\(count)"
            helper.writeScreenshot(snap, dir: url, name: name)

            if count >= max {
                print("scroll count \(count)")
                return
            }
        }
    }
    
    func testMoveOneHittableSet() -> Bool {
        let cellList: [XCUIElement] = app.cells.allElementsBoundByIndex
        
        var firstCell: XCUIElement! = nil
        var lastCell: XCUIElement! = nil                
        
        if let endCell = cellList.last, endCell.isHittable {
             return false
        }
        
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
        
        print("firstCell.debugDescription: \(firstCell.debugDescription)")
        print("lastCell.debugDescription: \(lastCell.debugDescription)")
        
        let normal05 = CGVector(dx: 0.5, dy: 0.5)
        let firstCoord = firstCell.coordinate(withNormalizedOffset: normal05)
        let lastCoord = lastCell.coordinate(withNormalizedOffset: normal05)

        print("firstCoord.debugDescription: \(firstCoord.debugDescription)")
        print("lastCoord.debugDescription: \(lastCoord.debugDescription)")

        // raw(100): 100.00 pixels per second
        //     slow: 250.00 pixels per second
        //  default: 500.00 pixels per second
        //     fast: 750.00 pixels per second
        //let velocity = XCUIGestureVelocity(100.00) // pixels per second
        let velocity = XCUIGestureVelocity.slow

        lastCoord.press(
            forDuration: 0.1,        // seconds 
            thenDragTo: firstCoord, 
            withVelocity: velocity, 
            thenHoldForDuration: 0.1 // seconds
        )
        
        print(":DEBUG:")
        return true
    }
    
    //let rect: CGRect = mainWindow.frame
        // .origin, .size: .height, .width (CGFloat)
        // .minX, .midX, .maxX
    
    // coordinate.withOffset(CGVector) -> XCUICoordinate
    // element.coordinate(withNormalizedOffset: CGVector) -> XCUICoordinate
    // element.frame -> CGRect
    
    // CGFloat
    // CGPoint(x, y)
    // CGSize(width, height)
    // CGRect(origin: CGPoint, size: CGSize)
    // CGVector(dx, dy)

    //topScreenPoint.withOffset(offsetVector: CGVector)
}
