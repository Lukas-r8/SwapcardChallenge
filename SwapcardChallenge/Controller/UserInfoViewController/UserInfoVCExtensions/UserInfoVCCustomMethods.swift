//
//  UserInfoVCCustomMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

//CustomMethods
extension UserInfoViewController {
    func setUpViewsAndConstraints(){
        view.addMultipleViews(UserImageView,natImageView, nameLabel, contactLabel, locationLabel, accountLabel, callMapButton, favButton ,mapCard)
        
        let labelsSpacing: CGFloat = 7
        
        UserImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        UserImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        UserImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        UserImageView.heightAnchor.constraint(equalTo: UserImageView.widthAnchor).isActive = true
        
        natImageView.leftAnchor.constraint(equalTo: UserImageView.rightAnchor, constant: 0).isActive = true
        natImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        natImageView.heightAnchor.constraint(equalTo: UserImageView.heightAnchor).isActive = true
        natImageView.topAnchor.constraint(equalTo: UserImageView.topAnchor, constant: 0).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        nameLabel.topAnchor.constraint(equalTo: UserImageView.bottomAnchor, constant: labelsSpacing).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        contactLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        contactLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: labelsSpacing).isActive = true
        contactLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        accountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        accountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        accountLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: labelsSpacing).isActive = true
        accountLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        locationLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: labelsSpacing).isActive = true
        locationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        callMapButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -45).isActive = true
        callMapButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        callMapButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        callMapButton.widthAnchor.constraint(equalTo: callMapButton.heightAnchor, multiplier: 0.65).isActive = true
        
        favButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 45).isActive = true
        favButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        favButton.widthAnchor.constraint(equalTo: favButton.heightAnchor).isActive = true
        
    }
    
}

