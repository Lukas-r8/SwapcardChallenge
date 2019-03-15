//
//  usersList.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class UsersListTableViewController: UITableViewController {

    var cellReuseIdentifier = "usersTableViewCell"
    
    var allUsers = [User]()
    var onlyFavUsers: [User]  {
        return allUsers.filter({FavouriteUsersButton.arrayID.contains($0.login.uuid)})
    }
    
    var usersData: [User] {return favMode ? onlyFavUsers : allUsers}
    
    var favMode = false
    
    lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPage), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    let switchListButton: UIButton = UIButton(type: UIButton.ButtonType.system)


    override func viewDidLoad() {
        super.viewDidLoad()
        switchListButton.titleLabel?.font = UIFont(name: AppFonts.bold, size: 20)
        setupTableView()
        fetchData()
    }
  
}


