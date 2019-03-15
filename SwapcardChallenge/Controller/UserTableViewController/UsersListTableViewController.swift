//
//  usersList.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class UsersListTableViewController: UITableViewController, UserInfoDelegate {

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
        NotificationCenter.default.addObserver(forName: .favouritePressed, object: nil, queue: nil) { (not) in
            if self.favMode {
                if let index = not.userInfo?["indexToRemove"] as? Int{
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                }
            }
        }
        setupTableView()
        fetchData()
    }
    
    func findIndexByStr(_ str: String) -> Int{
        var index = -1
        for (i, user) in onlyFavUsers.enumerated(){
            if user.login.uuid == str {
                index = i
            }
        }
        return index
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
    
    @objc func handleFavBarButton(){
        favMode = !favMode
        favMode ? switchListButton.setTitle("All Users", for: .normal) : switchListButton.setTitle("Favourites", for: .normal)
        let title = favMode ? "Favourites list" : "Users list"
        self.navigationItem.title = title
        
        tableView.beginUpdates()
        if favMode{
            tableView.deleteRows(at: rowsToAddOrDelete(), with: .fade)
        } else {
            tableView.insertRows(at: rowsToAddOrDelete(), with: .fade)
        }
        tableView.endUpdates()
    }
    
    func rowsToAddOrDelete() -> [IndexPath] {
        var res = [IndexPath]()
            for (i, user) in allUsers.enumerated() {
                if !FavouriteUsersButton.arrayID.contains(user.login.uuid) {
                    res.append(IndexPath(row: i, section: 0))
                }
            }
        return res
    }
    
    func favValueUpdated() {
        tableView.reloadData()
    }
    
    
    func fetchData(){
        APIConnection.shared.fetchData { (error, response) in
            if let error = error { print(error); return}
            if let res = response {
                self.allUsers = res.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    @objc func refreshPage(sender: UIRefreshControl){
        fetchData()
        sender.endRefreshing()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UsersTableViewCell
        cell.user = usersData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userInfo = UserInfoViewController()
        userInfo.userData = usersData[indexPath.row]
        userInfo.delegate = self
        
        navigationController?.pushViewController(userInfo, animated: true)
        
        
        
        
        
    }
    
    
}
