//
//  RandomMemeUseCaseTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
import Foundation
@testable import Humor_TCA

struct RandomMemeUseCaseTests {
    struct MockHumorRepository: HumorRepository {
        var memeToReturn: Meme

        func searchJokes(keywords: String, number: Int) async throws -> [Joke] { [] }

        func randomJoke() async throws -> Joke {
            throw NSError(domain: "not-used", code: 0)
        }

        func randomMeme() async throws -> Meme {
            memeToReturn
        }
    }

    @Test
    func returnsMemeFromRepository() async throws {
        let expected = Meme(id: 42, urlString: "https://example.com/meme.jpg", type: "meme")
        let repo = MockHumorRepository(memeToReturn: expected)
        let useCase = RandomMemeUseCase(repository: repo)

        let result = try await useCase.execute()

        #expect(result.id == expected.id)
        #expect(result.type == expected.type)
        #expect(result.urlString == expected.urlString)
        #expect(result.url?.absoluteString == expected.url?.absoluteString)
    }

    @Test
    func throwsIfRepositoryFails() async {
        struct FailingRepo: HumorRepository {
            func searchJokes(keywords: String, number: Int) async throws -> [Joke] { [] }
            func randomJoke() async throws -> Joke { throw NSError(domain: "", code: 0) }
            func randomMeme() async throws -> Meme {
                throw NSError(domain: "meme-error", code: 999)
            }
        }

        let useCase = RandomMemeUseCase(repository: FailingRepo())

        await #expect(throws: (any Error).self) {
            try await useCase.execute()
        }
    }
}
