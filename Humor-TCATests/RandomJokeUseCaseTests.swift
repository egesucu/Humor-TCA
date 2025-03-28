//
//  RandomJokeUseCaseTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
import Foundation
@testable import Humor_TCA

struct RandomJokeUseCaseTests {
    struct MockHumorRepository: HumorRepository {
        var jokeToReturn: Joke

        func searchJokes(keywords: String, number: Int) async throws -> [Joke] {
            []
        }

        func randomJoke() async throws -> Joke {
            jokeToReturn
        }

        func randomMeme() async throws -> Meme {
            throw NSError(domain: "Not needed", code: 0)
        }
    }

    @Test
    func returnsJokeFromRepository() async throws {
        // Given
        let expected = Joke(id: 123, joke: "Mocked random joke")
        let repo = MockHumorRepository(jokeToReturn: expected)
        let useCase = RandomJokeUseCase(repository: repo)

        // When
        let result = try await useCase.execute()

        // Then
        #expect(result.id == expected.id)
        #expect(result.joke == expected.joke)
    }

    @Test
    func throwsIfRepositoryFails() async {
        struct FailingRepo: HumorRepository {
            func searchJokes(keywords: String, number: Int) async throws -> [Joke] { [] }
            func randomJoke() async throws -> Joke {
                throw NSError(domain: "test", code: 1)
            }
            func randomMeme() async throws -> Meme {
                throw NSError(domain: "irrelevant", code: 0)
            }
        }

        let useCase = RandomJokeUseCase(repository: FailingRepo())

        await #expect(throws: (any Error).self) {
            try await useCase.execute()
        }
    }
}
