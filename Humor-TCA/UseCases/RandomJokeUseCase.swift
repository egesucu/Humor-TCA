//
//  FetchRandomJokeUseCase.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

struct RandomJokeUseCase {
    private let repository: any HumorRepository
    
    init(repository: any HumorRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> Joke {
        try await repository.randomJoke()
    }
}
