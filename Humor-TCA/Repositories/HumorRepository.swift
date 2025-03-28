//
//  HumorRepository.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

protocol HumorRepository: Sendable {
    
    func searchJokes(keywords: String, number: Int) async throws -> [Joke]
    
    func randomJoke() async throws -> Joke
    
    func randomMeme() async throws -> Meme
}
