//
//  EasySpare_ExpensesApp_UITestsLaunchTests.swift
//  EasySpare(ExpensesApp)UITests
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import XCTest

final class EasySpare_ExpensesApp_UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
