//
//  ObjcCellMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

//@objc cellMethods
extension UsersTableViewCell{
    @objc func handleFavourite(sender: FavouriteUsersButton){
        // If favMode is on button is handled in tableviewController if it's off it's handled on completion handler
        getTableVC().findIndexAndRemoveRow(sender, completion: { favMode in
            if !favMode {
                favouriteButton.isFavourite = !favouriteButton.isFavourite
            }
        })
    }
}
