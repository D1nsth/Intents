//
//  ContentStruct.swift
//  Intents
//
//  Created by Никита on 26.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Content: Codable {
    var id: Int
    var content: String
    var is_marked_up: Bool
    var categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case is_marked_up
        case categories
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(is_marked_up, forKey: .is_marked_up)
        try container.encode(categories, forKey: .categories)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        is_marked_up = try container.decode(Bool.self, forKey: .is_marked_up)
        categories = try container.decode([Category].self, forKey: .categories)
    }
}
