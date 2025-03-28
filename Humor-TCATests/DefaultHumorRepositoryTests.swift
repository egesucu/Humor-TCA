//
//  DefaultHumorRepositoryTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//


//
//  DefaultHumorRepositoryTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Testing
@testable import Humor_TCA

struct DefaultHumorRepositoryTests {
    @Test
    func searchJokes_withInvalidKeyword_shouldThrowEmptySearchQuery() async {
        let repo = DefaultHumorRepository()
        
        await #expect {
            try await repo.searchJokes(keywords: "   ", number: 3)
        } throws: { error in
            guard let apiError = error as? APIErrors else { return false }
            return apiError == .emptySearchQuery
        }
    }

    @Test
    func searchJokes_withInvalidURL_shouldThrowInvalidURL() async {
        let repo = DefaultHumorRepository(fakeApiKey: "dfds")

        await #expect {
            try await repo.searchJokes(keywords: "funny", number: 3)
        } throws: { error in
            guard let apiError = error as? APIErrors else { return false }
            return apiError == .invalidURL
        }
    }
    
    @Test
    func searchJokes_withInvalidURL_showThrowInvalidResponse() async {
        let repo = DefaultHumorRepository(fakeBaseURL: "https://www.google.com")
        
        await #expect {
            try await repo.searchJokes(keywords: "funny", number: 3)
        } throws: { error in
            guard let apiError = error as? APIErrors else { return false }
            return apiError == .invalidResponse
        }
    }
}
