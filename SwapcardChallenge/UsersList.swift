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
    var refresh = UIRefreshControl()
    
    var allUsers = [User]()
    var onlyFavUsers: [User]  {
        return allUsers.filter({FavouriteUsersButton.arrayID.contains($0.login.uuid)})
    }
    
    var usersData: [User] {return favMode ? onlyFavUsers : allUsers}
    
    var favMode = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        refresh.addTarget(self, action: #selector(refreshPage), for: UIControl.Event.valueChanged)
        fetchData()
    }
    
    
    func setupTableView(){
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier )
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refresh
        self.navigationItem.title = "User's list"
        setUpTabBarItem()
    }
    
    let button = UIButton(type: UIButton.ButtonType.system)

    func setUpTabBarItem(){
        button.setTitle("Favourites", for: UIControl.State.normal)
        button.frame.size = CGSize(width: 100, height: 25)
        button.addTarget(self, action: #selector(handleFavBarButton), for: .touchUpInside)
        let favBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = favBarButton
    }
    
    @objc func handleFavBarButton(){
        favMode = !favMode
        favMode ? button.setTitle("All Users", for: .normal) : button.setTitle("Favourites", for: .normal)
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: UITableView.RowAnimation.middle)
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
    
    
}



































class UsersTableViewCell: UITableViewCell {
    
    var user: User? {
        didSet{
            if var user = user {
                avatarImageView.getImageFromURL(user.picture, imageSizeType: .large)
                nameLabel.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
                emailLabel.text = user.email
                
                favouriteButton = user.favouritesHandler
                favouriteButton.tintColor = user.favouritesHandler.isFavourite ? UIColor.appTheme.favColor : UIColor.appTheme.nonFavColor
                favouriteButton.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)

                setUpSubViewsAndConstraints()
            }
        }
    }
    
    let imageViewHeight: CGFloat = 100
    
    
    private let containerView: UIView = {
            let container = UIView()
            container.backgroundColor = .white
            container.layer.cornerRadius = 10
            container.translatesAutoresizingMaskIntoConstraints = false
            container.addShadow()
            return container
        }()
    
    var favouriteButton: FavouriteUsersButton!
    
   private lazy var  avatarImageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.backgroundColor = .gray
            image.contentMode = UIView.ContentMode.scaleAspectFill
            image.layer.cornerRadius = imageViewHeight / 2
            image.clipsToBounds = true
            return image
        }()
    
    private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "IowanOldStyle-Bold", size: 25)
            label.textColor = UIColor.black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Lucas Alves da Silva"
            return label
        }()
    
    private let emailLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "IowanOldStyle-Italic", size: 16)
            label.textColor = UIColor.gray
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "email: lukas@test.com"
            return label
        }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpCell(){
        backgroundColor = .white
    
    }
    
    @objc func handleFavourite(sender: UIButton){
        if var user = user{
            user.favouritesHandler.isFavourite = !user.favouritesHandler.isFavourite
            sender.tintColor = user.favouritesHandler.isFavourite ? UIColor.appTheme.favColor : UIColor.appTheme.nonFavColor
        }
    }
    
    func setUpSubViewsAndConstraints(){
        addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(favouriteButton)
        
        let constantSpacing: CGFloat = 8
        
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: constantSpacing).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constantSpacing).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: constantSpacing).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -constantSpacing).isActive = true

        
        avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: constantSpacing).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: constantSpacing).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -constantSpacing).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: constantSpacing).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: favouriteButton.leftAnchor, constant: -constantSpacing).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constantSpacing).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        favouriteButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -constantSpacing).isActive = true
        favouriteButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constantSpacing).isActive =  true
        favouriteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favouriteButton.heightAnchor.constraint(equalTo: favouriteButton.widthAnchor).isActive = true

    }
    
    
    
}
