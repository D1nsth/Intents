//
//  CategorizedNetService.swift
//  Intents
//
//  Created by Никита on 26.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

class CategorizedNetService {
    
    private init() { }
    
    static func getCategorizedContent(completion: @escaping(GetContentResponses) -> ()) throws {
        let stringUrl = "https://intent-classification-app.herokuapp.com/api/requests/?is_marked_up=1"
        guard let url = URL(string: stringUrl) else { return }
        
        try? NetworkService.shared.getData(url: url) { (data) in
            let response = GetContentResponses(data: data)
            completion(response)
        }
        
    }
    
}
