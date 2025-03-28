//
//  JokeTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
@testable import Humor_TCA
import Foundation

struct JokeTests {
    @Test
    func decodingValidJokeJSON() throws {
        let json = """
        {
            "id": "abc123",
            "joke": "Why did the chicken join a band? Because it had the drumsticks!"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Joke.self, from: json)

        #expect(decoded.id == "abc123")
        #expect(decoded.joke == "Why did the chicken join a band? Because it had the drumsticks!")
    }

    @Test
    func decodingInvalidJokeJSON_shouldThrow() {
        let json = """
        {
            "identifier": "nope",
            "content": "missing expected keys"
        }
        """.data(using: .utf8)!

        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Joke.self, from: json)
        }
    }
}
