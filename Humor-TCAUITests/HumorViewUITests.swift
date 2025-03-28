//
//  HumorViewUITests.swift
//  Humor-TCAUITests
//
//  Created by Sucu, Ege on 28.03.2025.
//

import XCTest

@MainActor
final class HumorViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testJokeAndMemeOfTheDayLoad() {
        let app = XCUIApplication()
        app.launch()

        let jokeOfTheDayTitle = app.staticTexts["Joke of the Day"]
        let memeOfTheDayTitle = app.staticTexts["Meme of the Day"]

        // Check for titles
        XCTAssertTrue(jokeOfTheDayTitle.waitForExistence(timeout: 5))
        XCTAssertTrue(memeOfTheDayTitle.waitForExistence(timeout: 5))

        // Check for joke content
        let jokeContent = app.staticTexts.element(boundBy: 1)
        XCTAssertTrue(jokeContent.exists)
    }

    func testSearchJokeFlow() {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["Enter search query..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))

        searchField.tap()
        searchField.typeText("cat")

        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()

        let firstResult = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] %@", "cat")).firstMatch
        XCTAssertTrue(firstResult.waitForExistence(timeout: 5))
    }
}
