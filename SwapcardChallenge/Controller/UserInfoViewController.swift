//
//  UsersInfoViewController.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class UserInfoViewController: UIViewController {
    
    
    var userData: User! {
        didSet{
            favButton = userData.favouritesHandler
            favButton.addTarget(self, action: #selector(handleFavButton), for: .touchUpInside)
            
            UserImageView.getImageFromURL(userData.picture, imageSizeType: .large)
            natImageView.image = UIImage(named: "\(userData.nat)_flag")
            
            let isFemale = userData.gender == "female" ? true : false
            
            nameLabel.isFemale = isFemale
            nameLabel.text = "Name: \(userData.name.first) \(userData.name.last), \(userData.dob.age)"
            
            contactLabel.isFemale = isFemale
            contactLabel.text = "Contact info:\nEmail: \(userData.email)\nPhone: \(userData.phone)\nMobile: \(userData.cell)"
            
            accountLabel.isFemale = isFemale
            accountLabel.text = "Account info:\nUsername: \(userData.login.username)\nRegistered: \(userData.registered.age) years ago\nRegister Date: \(userData.registered.date.formattedStrDate())\nBirthday: \(userData.dob.date.formattedStrDate())"

            let loc = userData.location
            locationLabel.isFemale = isFemale
            locationLabel.text = "Location info:\nCity: \(loc.city)\nState: \(loc.state)\nStreet: \(loc.street)\nPostcode: \(loc.postcode.rawString())\nTimezone: \(loc.timezone.description)"
            
        }
    }
    var favButton: FavouriteUsersButton!
    var delegate: UserInfoDelegate?
    
    lazy var mapCard = MapCardView(frame: CGRect.zero, parent: self)
    
    lazy var callMapButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "mapButton"), for: UIControl.State.normal)
        button.setTitle("blabla", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCallMapButton), for: .touchUpInside)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    let UserImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        return imgView
    }()
    
    let natImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 10
        imgView.backgroundColor = .clear
        imgView.clipsToBounds = true
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        return imgView
    }()
    
    
    let nameLabel: InfoLabel = {
        let label = InfoLabel()
        label.font = UIFont(name: AppFonts.bold, size: 30)
        return label
    }()
    
    let contactLabel: InfoLabel = {
        let label = InfoLabel()
        return label
    }()
    
    let locationLabel: InfoLabel = {
        let label = InfoLabel()
        return label
    }()
    
    let accountLabel: InfoLabel = {
        let label = InfoLabel()
        return label
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "User's Info"
        setUpViewsAndConstraints()
    }
    
    
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
    
    
    @objc func handleCallMapButton(sender: UIButton){
        mapCard.show()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapCard.removeFromSuperview()
    }
    
    @objc func handleFavButton(sender: FavouriteUsersButton){
        userData.favouritesHandler.isFavourite = !userData.favouritesHandler.isFavourite
        sender.tintColor = userData.favouritesHandler.isFavourite ? AppColors.favColor : AppColors.nonFavColor
        delegate?.favValueUpdated()
    }
    
    
    deinit {
        print("users info is deiniting", userData.email)
    }
    
 
    
}


