//
//  DefaultHumorRepository.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

class DefaultHumorRepository: HumorRepository {
    private lazy var apiKey: String? = {
        guard let fileURL = Bundle.main.url(forResource: "api_key", withExtension: "txt"),
              let key = try? String(contentsOf: fileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines),
              !key.isEmpty else {
            print("⚠️ Failed to load API key from api_key.txt")
            return nil
        }
        return key
    }()
    
    private let baseURL = "https://api.humorapi.com"
    
    func searchJokes(keywords: String, number: Int) async throws(APIErrors) -> [Joke] {
        let searchQuery = keywords.replacingOccurrences(of: " ", with: ",")
        guard searchQuery.isNotEmpty else {
            print("Search query is empty, skipping the search")
            throw .emptySearchQuery
        }
        guard let apiKey,
              let url = URL(string: "\(baseURL)/jokes/search?api-key=\(apiKey)&number=\(number)&keywords=\(searchQuery)") else {
            throw .invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIErrors.invalidResponse
            }
            
            let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
            return searchResponse.jokes
        } catch {
            print("Decoding has failed: \(error)")
            throw .decodingFailed
        }
    }
    
    func randomJoke() async throws(APIErrors) -> Joke {
        guard let apiKey,
              let url = URL(string: "\(baseURL)/jokes/random?api-key=\(apiKey)") else {
            throw .invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIErrors.invalidResponse
            }
            return try JSONDecoder().decode(Joke.self, from: data)
        } catch {
            print("Decoding has failed: \(error)")
            throw .decodingFailed
        }
    }
    
    func randomMeme() async throws(APIErrors) -> Meme {
        guard let apiKey,
              let url = URL(string: "\(baseURL)/memes/random?api-key=\(apiKey)") else {
            throw .invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIErrors.invalidResponse
            }
            return try JSONDecoder().decode(Meme.self, from: data)
        } catch {
            print("Decoding has failed: \(error)")
            throw .decodingFailed
        }
    }
}

enum APIErrors: String, Error {
    case invalidURL = "The given URL is invalid"
    case invalidResponse = "The response is not valid."
    case decodingFailed = "Decoding has failed."
    case emptySearchQuery = "The search query is empty."
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

// The API returns a JSON with a "jokes" key containing an array of jokes.
struct SearchResponse: Decodable {
    let jokes: [Joke]
}
