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
    weak var delegate: UserInfoDelegate?
    
    lazy var mapCard = MapCardView(parent: self)
    
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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        mapCard?.removeFromSuperview()
//    }
//    

    deinit {
        print("users info is deinitializing", userData.email)
    }

}
