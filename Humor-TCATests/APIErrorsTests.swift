//
//  APIErrorsTests.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 29.03.2025.
//

import Testing
@testable import Humor_TCA

struct APIErrorsTests {
    @Test
    func errorDescription_forInvalidURL_isCorrect() {
        let error = APIErrors.invalidURL
        #expect(error.localizedDescription == "The given URL is invalid")
    }

    @Test
    func errorDescription_forInvalidResponse_isCorrect() {
        let error = APIErrors.invalidResponse
        #expect(error.localizedDescription == "The response is not valid.")
    }

    @Test
    func errorDescription_forDecodingFailed_isCorrect() {
        let error = APIErrors.decodingFailed
        #expect(error.localizedDescription == "Decoding has failed.")
    }

    @Test
    func errorDescription_forEmptySearchQuery_isCorrect() {
        let error = APIErrors.emptySearchQuery
        #expect(error.localizedDescription == "The search query is empty.")
    }
}
