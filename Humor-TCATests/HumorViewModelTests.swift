//
//  HumorViewModelTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 29.03.2025.
//

import Testing
@testable import Humor_TCA
import Foundation

struct HumorViewModelTests {
    
    struct MockUseCases {
        struct Success: Sendable {
            let search = SearchJokeUseCase(repository: MockHumorRepository())
            let joke = RandomJokeUseCase(repository: MockHumorRepository())
            let meme = RandomMemeUseCase(repository: MockHumorRepository())
        }
    }

    @Test
    @MainActor
    func testSearchJokesUpdatesJokesArray() async throws {
        let useCases = MockUseCases.Success()
        let vm = HumorViewModel(
            randomJokeUseCase: useCases.joke,
            searchJokeUseCase: useCases.search,
            randomMemeUseCase: useCases.meme
        )

        vm.searchQuery = "test"
        await vm.searchJokes()

        #expect(vm.jokes.count == 10)
        #expect(vm.jokes[0].joke == "Mock joke 1 for keyword 'test'")
    }

    @Test
    func testLoadRandomDataSetsJokeAndMeme() async throws {
        let useCases = MockUseCases.Success()
        let vm = await HumorViewModel(
            randomJokeUseCase: useCases.joke,
            searchJokeUseCase: useCases.search,
            randomMemeUseCase: useCases.meme
        )

        await vm.loadRandomData()

        await #expect(vm.joke?.joke == "Why don't skeletons fight each other? Because they don't have the guts.")
        await #expect(vm.meme?.urlString == "https://i.imgflip.com/1bij.jpg")
        await #expect(vm.isLoading == false)
        await #expect(vm.errorMessage == nil)
    }
}
