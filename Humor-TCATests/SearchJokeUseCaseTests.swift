//
//  SearchJokeUseCaseTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
import Foundation
@testable import Humor_TCA

struct SearchJokeUseCaseTests {
    struct MockHumorRepository: HumorRepository {
        var jokesToReturn: [Joke]

        func searchJokes(keywords: String, number: Int) async throws -> [Joke] {
            jokesToReturn
        }

        func randomJoke() async throws -> Joke {
            throw NSError(domain: "not-used", code: 0)
        }

        func randomMeme() async throws -> Meme {
            throw NSError(domain: "not-used", code: 0)
        }
    }

    @Test
    func returnsExpectedJokes() async throws {
        // Given
        let expectedJokes = [
            Joke(id: 1, joke: "Why don't scientists trust atoms? Because they make up everything."),
            Joke(id: 2, joke: "I told my computer I needed a break, and now it won't stop sending me beach pictures.")
        ]
        let mockRepo = MockHumorRepository(jokesToReturn: expectedJokes)
        let useCase = SearchJokeUseCase(repository: mockRepo)

        // When
        let result = try await useCase.execute(searchTerms: "science", number: 2)

        // Then
        #expect(result.count == 2)
        #expect(result[0].joke.contains("atoms"))
        #expect(result[1].joke.contains("computer"))
    }

    @Test
    func throwsIfRepositoryFails() async {
        struct FailingRepo: HumorRepository {
            func searchJokes(keywords: String, number: Int) async throws -> [Joke] {
                throw NSError(domain: "fail", code: 500)
            }
            func randomJoke() async throws -> Joke { throw NSError(domain: "", code: 0) }
            func randomMeme() async throws -> Meme { throw NSError(domain: "", code: 0) }
        }

        let useCase = SearchJokeUseCase(repository: FailingRepo())

        await #expect(throws: (any Error).self ) {
            try await useCase.execute(searchTerms: "fail")
        }
    }
}
