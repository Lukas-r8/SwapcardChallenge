//
//  CustomMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

// Custom Methods
extension UsersListTableViewController {
    func rowsToAddOrDelete() -> [IndexPath] {
        var res = [IndexPath]()
        for (i, user) in allUsers.enumerated() {
            if !FavouriteUsersButton.arrayID.contains(user.login.uuid) {
                res.append(IndexPath(row: i, section: 0))
            }
        }
        return res
    }
    
    func findIndexAndRemoveRow(_ sender: FavouriteUsersButton, completion: (Bool) -> Void){
        var index = -1
        for (i, user) in onlyFavUsers.enumerated(){
            if user.login.uuid == sender.id {
                index = i
            }
        }
        if index != -1 {
            sender.isFavourite = !sender.isFavourite
            if favMode {
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                tableView.endUpdates()
            }
        }
        
        completion(favMode)
    }
    
    
    func setupTableView(){
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier )
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refresh
        self.navigationItem.title = "Users list"
        setUpTabBarItem()
    }
    
    
    func setUpTabBarItem(){
        switchListButton.setTitle("Favourites", for: UIControl.State.normal)
        switchListButton.frame.size = CGSize(width: 100, height: 25)
        switchListButton.addTarget(self, action: #selector(handleFavBarButton), for: .touchUpInside)
        let favBarButton = UIBarButtonItem(customView: switchListButton)
        navigationItem.rightBarButtonItem = favBarButton
    }
    
    
    func fetchData(){
        APIConnection.shared.fetchData { (error, response) in
            if let error = error {
                self.present(error.showError(), animated: true, completion: {
                    print("error presented")
                })
                return}
            if let res = response {
                self.allUsers = res.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

