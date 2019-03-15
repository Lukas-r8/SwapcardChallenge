//
//  CellCustomMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

//CustomMethods
extension UsersTableViewCell {
    func getTableVC() -> UsersListTableViewController{
        if let table = self.superview as? UITableView  {
            if let TVC = table.delegate as? UsersListTableViewController {
                return TVC
            }
        }
        return UsersListTableViewController()
    }
    
    func setUpSubViewsAndConstraints(){
        addSubview(containerView)
        
        containerView.addMultipleViews(avatarImageView,nameLabel,emailLabel,favouriteButton)
        
        let constantSpacing: CGFloat = 8
        
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: constantSpacing).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constantSpacing).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: constantSpacing).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -constantSpacing).isActive = true
        
        
        avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: constantSpacing).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: constantSpacing).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -constantSpacing).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: constantSpacing).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: favouriteButton.leftAnchor, constant: -constantSpacing).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constantSpacing).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        favouriteButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -constantSpacing).isActive = true
        favouriteButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constantSpacing).isActive =  true
        favouriteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favouriteButton.heightAnchor.constraint(equalTo: favouriteButton.widthAnchor).isActive = true
        
    }
}
