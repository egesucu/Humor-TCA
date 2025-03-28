//
//  Meme.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation
import UIKit

struct Meme: Identifiable, Decodable {
    let id: Int
    let urlString: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case urlString = "url"
        case type
    }
    
    var url: URL? {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return nil}
        return url
    }
    
}
