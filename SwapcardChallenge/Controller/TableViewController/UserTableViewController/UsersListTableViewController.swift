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
    
    var allUsers: [User] = [User](){
        didSet{
            needFetchMore = true
        }
    }
    
    var onlyFavUsers: [User]  {
        return allUsers.filter({FavouriteUsersButton.arrayID.contains($0.login.uuid)})
    }
    
    var usersData: [User] {return favMode ? onlyFavUsers : allUsers}
    
    var favMode = false
    var needFetchMore = false
    
    var pageValue = 1
    
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
        fetchData(page: pageValue)
    }
    
   
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if favMode {return}
        if needFetchMore {
            let offsetY = scrollView.contentOffset.y
            if offsetY > scrollView.contentSize.height - scrollView.frame.height + 100 {
                pageValue += 1
                fetchData(page: pageValue)
                needFetchMore = !needFetchMore
            }
        }
 
    }
    
    
}


