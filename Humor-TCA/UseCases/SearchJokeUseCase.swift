//
//  SearchJokeUseCase.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

struct SearchJokeUseCase {
    
    private let repository: HumorRepository
    
    struct Constants {
        static let defaultNumberOfJokes: Int = 10
    }
    
    init(repository: HumorRepository) {
        self.repository = repository
    }
    
    func execute(searchTerms: String, number: Int = Constants.defaultNumberOfJokes) async throws -> [Joke] {
        try await repository.searchJokes(keywords: searchTerms, number: number)
    }
}
