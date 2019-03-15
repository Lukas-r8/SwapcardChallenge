//
//  ApiConnection.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 12/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit


class APIConnection {
    static let shared = APIConnection()
    
    func fetchData(callback: @escaping (Error?, Response?) -> Void){
        guard let url = URL(string: "https://randomuser.me/api/?results=100&page=1&seed=seedOne") else {return}
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, header, error) in
            if let err = error { callback(err, nil); return }
            guard let data = data else {return}
            do {
                let JSONData = try JSONDecoder().decode(Response.self, from: data)
                callback(nil, JSONData)
            } catch let err {
                callback(err, nil)
            }
            
        }
        task.resume()
        
    }
    
}
