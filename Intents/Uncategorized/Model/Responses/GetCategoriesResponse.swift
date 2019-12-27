//
//  GetCategoriesResponse.swift
//  Intents
//
//  Created by Никита on 25.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct GetCategoriesResponse {
    
    typealias JSON = [String: AnyObject]
    let resultCategories: [Category]
    
    init(data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSON
            let errorJson = json["error"]
            
            if (errorJson is NSNull) {
                let resultJson = json["result"] as! [JSON]
                let dataResult = try JSONSerialization.data(withJSONObject: resultJson, options: [])
                
                self.resultCategories = try JSONDecoder().decode([Category].self, from: dataResult)
                
            } else {
                print(errorJson as Any)
                self.resultCategories = []
            }
            
        } catch {
            print(error.localizedDescription)
            self.resultCategories = []
        }
    }
    
}
