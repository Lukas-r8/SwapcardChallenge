//
//  UserInfoDelegateMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation

//userInfoDelegate Methods
extension UsersListTableViewController: UserInfoDelegate {
    func favValueUpdated() {
        tableView.reloadData()
    }
}
