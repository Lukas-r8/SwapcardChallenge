//
//  ObjcMethods.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 15/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

//@Objc methods
extension UsersListTableViewController {
    
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
    
    @objc func refreshPage(sender: UIRefreshControl){
        fetchData()
        sender.endRefreshing()
    }
    
}
