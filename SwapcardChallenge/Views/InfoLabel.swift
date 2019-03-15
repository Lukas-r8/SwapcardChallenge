//
//  InfoLabel.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 14/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit


class InfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpviewAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isFemale = true {
        didSet{
            separator.backgroundColor = isFemale ?  UIColor(cgColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)) : UIColor(cgColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        }
    }
    
    
    
    lazy var separator: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.layer.cornerRadius = 1
        sep.addShadow()
        return sep
    }()
    
    func setUp(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: AppThemeFonts.bold.rawValue, size: 17)
        textColor = UIColor.gray
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.byWordWrapping
        
    }
    
    
    func setUpviewAndConstraints(){
        addSubview(separator)
        
        separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
    }
    
    
    
}
