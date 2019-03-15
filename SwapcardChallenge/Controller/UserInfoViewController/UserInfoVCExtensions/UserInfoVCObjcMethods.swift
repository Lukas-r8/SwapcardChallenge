//
//  UserInfoVCObjcMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

//@ObjcMethods
extension UserInfoViewController {
    @objc func handleCallMapButton(sender: UIButton){
        mapCard.show()
    }
    
    @objc func handleFavButton(sender: FavouriteUsersButton){
        userData.favouritesHandler.isFavourite = !userData.favouritesHandler.isFavourite
        delegate?.favValueUpdated()
    }
}
