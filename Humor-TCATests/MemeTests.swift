//
//  MemeTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
import Foundation
@testable import Humor_TCA

struct MemeTests {
    @MainActor
    @Test
    func decodingValidMemeJSON_shouldSucceed() throws {
        let json = """
        {
            "id": 1,
            "url": "https://example.com/meme.jpg",
            "type": "meme"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Meme.self, from: json)

        #expect(decoded.id == 1)
        #expect(decoded.type == "meme")
        #expect(decoded.urlString == "https://example.com/meme.jpg")
        #expect(decoded.url?.absoluteString == "https://example.com/meme.jpg")
    }

    @MainActor
    @Test
    func decodingInvalidMemeJSON_shouldThrow() {
        let json = """
        {
            "identifier": "bad",
            "imageLink": "not-matching-key"
        }
        """.data(using: .utf8)!

        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Meme.self, from: json)
        }
    }

    @MainActor
    @Test
    func memeURLParsing_shouldReturnNilForInvalidURL() throws {
        let meme = Meme(id: 123, urlString: "not a url", type: "meme")
        #expect(meme.url == nil)
    }
}
