//
//  WordStruct.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Sentence {
    var sentence: String
    var categories: [String]
    
    init(_ sentence: String, categories: [String]) {
        self.sentence = sentence
        self.categories = categories
    }
}
