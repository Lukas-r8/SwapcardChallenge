//
//  UsersTableViewCell.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class UsersTableViewCell: UITableViewCell {
    
    var user: User? {
        didSet{
            if var user = user {
                avatarImageView.getImageFromURL(user.picture, imageSizeType: .large)
                nameLabel.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
                emailLabel.text = user.email
                
                favouriteButton = user.favouritesHandler
                favouriteButton.tintColor = user.favouritesHandler.isFavourite ? AppColors.favColor : AppColors.nonFavColor
                favouriteButton.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)
                
                setUpSubViewsAndConstraints()
            }
        }
    }
    
    let imageViewHeight: CGFloat = 100
    
    
     let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addShadow()
        return container
    }()
    
    var favouriteButton: FavouriteUsersButton!
    
     lazy var  avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.cornerRadius = imageViewHeight / 2
        image.clipsToBounds = true
        return image
    }()
    
     let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.bold, size: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.italic, size: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
