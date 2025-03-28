//
//  HumorViewModel.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import SwiftUI
import Observation

@MainActor
@Observable
class HumorViewModel {
    var searchQuery: String = ""
    var jokes: [Joke] = []
    var joke: Joke? = nil
    var meme: Meme? = nil
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let searchJokeUseCase: SearchJokeUseCase
    private let randomMemeUseCase: RandomMemeUseCase
    private let randomJokeUseCase: RandomJokeUseCase
    
    init(
        randomJokeUseCase: RandomJokeUseCase,
        searchJokeUseCase: SearchJokeUseCase,
        randomMemeUseCase: RandomMemeUseCase
    ) {
        self.randomJokeUseCase = randomJokeUseCase
        self.searchJokeUseCase = searchJokeUseCase
        self.randomMemeUseCase = randomMemeUseCase
    }
    
    func searchJokes() async {
        do {
            async let jokesResult = searchJokeUseCase.execute(searchTerms: searchQuery)
            jokes = try await jokesResult
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    @Sendable func loadRandomData() async {
        isLoading = true
        errorMessage = nil
        do {
            async let jokeResult = randomJokeUseCase.execute()
            async let memeResult = randomMemeUseCase.execute()
            
            joke = try await jokeResult
            meme = try await memeResult
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
}


