//
//  DelegateDataSourceMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

// Delegate/DataSource methods
extension UsersListTableViewController {
    
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
