//
//  MapCardView.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 14/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MapCardView: UIView {
    
    weak var parent: UserInfoViewController?
    
    var parentSafe: UserInfoViewController {
        get {
            if let safeParent = parent {
                return safeParent
            } else {
                print("wrong Parent")
                return UserInfoViewController()
            }
        }
    }
    
    var offSet: CGFloat {
        get { return parentSafe.view.frame.height * 0.8 }
    }

    lazy var cardConstDismissed = [topAnchor.constraint(equalTo: parentSafe.view.bottomAnchor),
                                   leftAnchor.constraint(equalTo: parentSafe.view.leftAnchor),
                                   widthAnchor.constraint(equalTo: parentSafe.view.widthAnchor),
                                   heightAnchor.constraint(equalTo: parentSafe.view.heightAnchor, multiplier: 0.8)]
    
    lazy var cardConstPresented = [topAnchor.constraint(equalTo: parentSafe.view.bottomAnchor, constant: -offSet),
                                   leftAnchor.constraint(equalTo: parentSafe.view.leftAnchor),
                                   widthAnchor.constraint(equalTo: parentSafe.view.widthAnchor),
                                   heightAnchor.constraint(equalTo: parentSafe.view.heightAnchor, multiplier: 0.8)]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Location"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AppFonts.bold, size: 20)
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: AppFonts.bold, size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismiss), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    
    required init(parent: UserInfoViewController) {
        self.parent = parent
        super.init(frame: CGRect.zero)
        setUp()
        setUpViewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUp(){
        setMapCoordinates()
        backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setMapCoordinates(){
        mapView.removeAnnotations(mapView.annotations)
        let userCoordinates = parentSafe.userData.location.coordinates
        guard let lat = Double(userCoordinates.latitude), let long = Double(userCoordinates.longitude) else {return}
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    
    
    func setUpViewsAndConstraints(){
        
        addMultipleViews(titleLabel, closeButton, mapView)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        mapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        mapView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        mapView.heightAnchor.constraint(equalTo: heightAnchor, constant: 0.9).isActive = true
        
    }
    
    
    
    func show(){
        setMapCoordinates()
        NSLayoutConstraint.activate(cardConstDismissed)
        parentSafe.view.layoutIfNeeded()
        NSLayoutConstraint.deactivate(cardConstDismissed)
        NSLayoutConstraint.activate(cardConstPresented)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.parentSafe.view.layoutIfNeeded()
        }) { (success) in
            
        }
    }
    
    @objc func dismiss(){
        NSLayoutConstraint.deactivate(cardConstPresented)
        NSLayoutConstraint.activate(cardConstDismissed)
        UIView.animate(withDuration: 0.3, animations: {
            self.parentSafe.view.layoutIfNeeded()
        }) { (success) in
            
        }
    }
    
 
    
    deinit {
        print("card deinitialized")
    }
    
    
}
