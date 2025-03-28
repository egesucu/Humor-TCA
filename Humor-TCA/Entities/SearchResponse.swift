//
//  SearchResponse.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

struct SearchResponse: Decodable {
    let jokes: [Joke]
}
