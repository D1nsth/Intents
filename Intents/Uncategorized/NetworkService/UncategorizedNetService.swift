//
//  UncategorizedNetService.swift
//  Intents
//
//  Created by Никита on 25.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

class UncategorizedNetService {
    
    private init() { }
    
    static func getCategoriesData(completion: @escaping(GetCategoriesResponse) -> ()) {
        let stringUrl = "https://intent-classification-app.herokuapp.com/api/categories"
        guard let url = URL(string: stringUrl) else { return }

        NetworkService.shared.getData(url: url) { (data) in
            let repsonse = GetCategoriesResponse(data: data)
            completion(repsonse)
        }

    }
    
    static func getUncategorizedContent(completion: @escaping(GetContentResponses) -> ()) {
        let stringUrl = "https://intent-classification-app.herokuapp.com/api/requests/?is_marked_up=0"
        guard let url = URL(string: stringUrl) else { return }
        
        NetworkService.shared.getData(url: url) { (data) in
            let response = GetContentResponses(data: data)
            completion(response)
        }
        
    }
    
    static func putUncategorizedContent(content: Content) {
        let stringUrl = "https://intent-classification-app.herokuapp.com/api/admin/requests/?id=\(content.id)/"
        guard let url = URL(string: stringUrl) else { return }
        
        let data = try! JSONEncoder().encode(content)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        NetworkService.shared.putData(request: request)
    }
    
}
