//
//  NetworkService.swift
//  Intents
//
//  Created by Никита on 25.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

class NetworkService {
    private init() { }
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (Data) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                if let e = error as? URLError, e.code == .notConnectedToInternet {
                    print("notConnectedToInternet")
                } else {
                    print(error?.localizedDescription as Any)
                }
                
            } else {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            
        }.resume()
    }
    
    public func putData(request: URLRequest) {
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let stringData = try String(data: data, encoding: .utf8)
                print(stringData)
                
            } catch {
                print(error)
            }
            
            if let error = error {
                print(error)
            }
            
        }.resume()
    }
    
    public func postData(request: URLRequest, completion: @escaping (Data) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
            
        }.resume()
    }
    
}
