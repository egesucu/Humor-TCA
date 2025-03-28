//
//  DefaultHumorRepository.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

final class DefaultHumorRepository: HumorRepository {
    private let apiKey: String?
    private let baseURL: String
    
    init() {
        self.apiKey = Self.loadAPIKey()
        self.baseURL = "https://api.humorapi.com"
    }
    
    /// This is a test case init, which uses apiKey to intentionally make apiKey nil
    init(
        fakeApiKey: String = "",
        fakeBaseURL: String = ""
    ) {
        if fakeApiKey.isNotEmpty {
            self.apiKey = nil
            self.baseURL = "https://api.humorapi.com"
        } else if fakeBaseURL.isNotEmpty {
            self.baseURL = ""
            self.apiKey = Self.loadAPIKey()
        } else {
            self.apiKey = Self.loadAPIKey()
            self.baseURL = "https://api.humorapi.com"
        }
    }
    
    private static func loadAPIKey() -> String? {
            guard let fileURL = Bundle.main.url(forResource: "api_key", withExtension: "txt"),
                  let key = try? String(contentsOf: fileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines),
                  !key.isEmpty else {
                return nil
            }
            return key
        }
    
   
    
    func searchJokes(keywords: String, number: Int) async throws(APIErrors) -> [Joke] {
        guard keywords.trimmingCharacters(in: .whitespacesAndNewlines).isNotEmpty else {
            print("Search query is empty, skipping the search")
            throw .emptySearchQuery
        }
        let searchQuery = keywords.replacingOccurrences(of: " ", with: ",")
        
        guard let apiKey,
              let url = URL(string: "\(baseURL)/jokes/search?api-key=\(apiKey)&number=\(number)&keywords=\(searchQuery)") else {
            throw .invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                return searchResponse.jokes
            } catch {
                print("Decoding has failed: \(error)")
                throw APIErrors.decodingFailed
            }
            
        } catch {
            throw .invalidResponse
        }
    }
    
    func randomJoke() async throws(APIErrors) -> Joke {
        guard let apiKey,
              let url = URL(string: "\(baseURL)/jokes/random?api-key=\(apiKey)") else {
            throw .invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                return try JSONDecoder().decode(Joke.self, from: data)
            } catch {
                print("Decoding has failed: \(error)")
                throw APIErrors.decodingFailed
            }
            
        } catch {
            throw .invalidResponse
        }
    }
    
    func randomMeme() async throws(APIErrors) -> Meme {
        guard let apiKey,
              let url = URL(string: "\(baseURL)/memes/random?api-key=\(apiKey)") else {
            throw .invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                return try JSONDecoder().decode(Meme.self, from: data)
            } catch {
                print("Decoding has failed: \(error)")
                throw APIErrors.decodingFailed
            }
            
        } catch {
            throw .invalidResponse
        }
    }
}
