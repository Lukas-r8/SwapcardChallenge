//
//  StringOrIntEnum.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation


enum StringOrInt: Codable {
    case string(String)
    case integer(Int)
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let str = try container.decode(String.self)
            self = StringOrInt.string(str)
        } catch  {
            do {
                let container = try decoder.singleValueContainer()
                let int = try container.decode(Int.self)
                self = StringOrInt.integer(int)
            } catch {
                throw DecodingError.typeMismatch(StringOrInt.self, .init(codingPath: decoder.codingPath, debugDescription: "expected String or Int but found none of these"))
            }
            
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        fatalError("encode function for StringOrInt not implemented yet")
    }
    
    func rawString() -> String {
        switch self {
        case .string(let str):
            return str
        case .integer(let int):
            return String(int)
        }
    }
    
}
