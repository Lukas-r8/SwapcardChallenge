//
//  FavouriteUsers.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class FavouriteUsers {
    static var arrayID = [String]()
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    
    var isFavourite: Bool {
        get {
            return FavouriteUsers.arrayID.contains(id)
        }
        set {
            if newValue {
                FavouriteUsers.arrayID.append(id)
            } else {
                FavouriteUsers.arrayID = FavouriteUsers.arrayID.filter({$0 != id})
            }
        }
    }
    
    
}
