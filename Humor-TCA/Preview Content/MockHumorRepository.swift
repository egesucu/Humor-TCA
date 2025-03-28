//
//  MockHumorRepository.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

final class MockHumorRepository: HumorRepository {
    
    func searchJokes(keywords: String, number: Int) async throws -> [Joke] {
        return (1...number).map { number in
            Joke(id: number, joke: "Mock joke \(number) for keyword '\(keywords)'")
        }
    }
    
    func randomJoke() async throws -> Joke {
        return Joke(id: 999, joke: "Why don't skeletons fight each other? Because they don't have the guts.")
    }
    
    func randomMeme() async throws -> Meme {
        return Meme(
            id: 123,
            urlString: "https://i.imgflip.com/1bij.jpg", // Sample meme image URL
            type: "meme"
        )
    }
}
