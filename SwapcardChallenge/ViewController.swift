//
//  ViewController.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 12/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import UIKit

class usersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        APIConnection.shared.fetchData { (err, res) in
           
            
        }
        
    }


}

