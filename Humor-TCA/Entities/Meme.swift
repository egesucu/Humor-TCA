//
//  Meme.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

struct Meme: Identifiable, Decodable {
    let id: String
    let urlString: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case urlString = "url"
        case type
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
}
