//
//  RandomMemeUseCase.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

struct RandomMemeUseCase {
    
    private let repository: HumorRepository
    
    init(repository: HumorRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> Meme {
        try await repository.randomMeme()
    }
}
