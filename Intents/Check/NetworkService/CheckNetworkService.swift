//
//  CheckNetworkService.swift
//  Intents
//
//  Created by Никита on 26.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation
 
class CheckNetworkService {
    
    private init() { }
    
    static func postCheckContent(content: String, completion: @escaping(String) -> ()) {
        let stringUrl = "https://intent-classification-app.herokuapp.com/api/predict_category/"
        guard let url = URL(string: stringUrl) else { return }
        
        print("Поехали")
        //let data = try! JSONEncoder().encode(content)
        let data = content.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        NetworkService.shared.postData(request: request) { (data) in
            do {
                let dataString = try String(data: data, encoding: .utf8)
                completion(dataString!)
            } catch {
                print(error)
                completion("")
            }
        }
        
    }
    
}
