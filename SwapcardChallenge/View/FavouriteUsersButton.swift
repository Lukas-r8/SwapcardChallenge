//
//  FavouriteUsers.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class FavouriteUsersButton: UIButton {
    let defaults = UserDefaults.standard
    static var arrayID = UserDefaults.standard.array(forKey: "favUsersArray") as! [String]
    
    var id: String
    
    override var buttonType: UIButton.ButtonType {
        return UIButton.ButtonType.custom
    }
    
     init(id: String) {
        self.id = id
        super.init(frame: CGRect.zero)
        setUpButton()
    }
    
    private var buttonTintColor: UIColor = AppColors.nonFavColor {
        didSet{
            tintColor = buttonTintColor
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpButton(){
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(named: "favouriteStar"), for: UIControl.State.normal)
        tintColor = isFavourite ? AppColors.favColor : AppColors.nonFavColor
    }
    
    
    var isFavourite: Bool {
        get {
            return FavouriteUsersButton.arrayID.contains(id)
        }
        set {
            if newValue {
                buttonTintColor = AppColors.favColor
                FavouriteUsersButton.arrayID.append(id)
                
            } else {
                buttonTintColor = AppColors.nonFavColor
                FavouriteUsersButton.arrayID = FavouriteUsersButton.arrayID.filter({$0 != id})
            }
            defaults.set(FavouriteUsersButton.arrayID, forKey: "favUsersArray")
            defaults.synchronize()
        }
    }
    
    
}
