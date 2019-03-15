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
    
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addShadow()
        return container
    }()
    
    var favouriteButton: FavouriteUsersButton!
    
    private lazy var  avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.cornerRadius = imageViewHeight / 2
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.bold, size: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.italic, size: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpCell(){
        backgroundColor = .white
        
    }
    
    @objc func handleFavourite(sender: FavouriteUsersButton){
        let indexToRemove = getTableVC().findIndexByStr(sender.id)
        if var user = user{
            user.favouritesHandler.isFavourite = !user.favouritesHandler.isFavourite
            sender.tintColor = user.favouritesHandler.isFavourite ? AppColors.favColor : AppColors.nonFavColor
            NotificationCenter.default.post(name: .favouritePressed, object: nil, userInfo: ["indexToRemove": indexToRemove])
        }
    }
    
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
