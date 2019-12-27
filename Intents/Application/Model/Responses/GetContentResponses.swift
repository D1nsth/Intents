//
//  GetContentResponses.swift
//  Intents
//
//  Created by Никита on 26.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct GetContentResponses {
    
    typealias JSON = [String: AnyObject]
    let resultContent: [Content]
    
    init(data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSON
            let errorJson = json["error"]
            
            if (errorJson is NSNull) {
                let resultJson = json["result"] as! [JSON]
                let dataResult = try JSONSerialization.data(withJSONObject: resultJson, options: [])
                
                self.resultContent = try JSONDecoder().decode([Content].self, from: dataResult)
                
            } else {
                print(errorJson as Any)
                self.resultContent = []
            }
            
        } catch {
            print(error.localizedDescription)
            self.resultContent = []
        }
    }
    
}
