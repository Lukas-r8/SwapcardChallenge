//
//  extensions.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit


//Helper Extensions

extension UIView {
    
    func addShadow(){
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.5, height: 2)
    }
    
    func addMultipleViews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}

extension UIImageView {
    func getImageFromURL(_ urlStrings: Picture, imageSizeType: ImageSize){
        var urlString: String
        switch imageSizeType {
        case .large:
            urlString = urlStrings.large
        case .medium:
            urlString = urlStrings.medium
        case .thumbnail:
            urlString = urlStrings.thumbnail
       
        }
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, header, error) in
            if let err = error {print(err.localizedDescription); return }
            if let data = data {
                let img = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }
        task.resume()
    }
}


extension String {
    
    func formattedStrDate() -> String {
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateForm.locale = Locale(identifier: "en_US")
        guard let date = dateForm.date(from: self) else {return "NO DATE"}
        dateForm.dateFormat = "dd/MM/yy - EEEE"
        let dateStr = dateForm.string(from: date)
        return dateStr
    }
    
}

extension Notification.Name {
    static let favouritePressed = Notification.Name(rawValue: "favouritePressed")
}


extension Error {
    func showError() -> UIAlertController{
        let alertController = UIAlertController(title: "ERROR", message: self.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        return alertController
    }
}
