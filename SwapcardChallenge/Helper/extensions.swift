//
//  extensions.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 13/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    func addShadow(){
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.5, height: 2)
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


extension UIColor {
    struct appTheme {
        static var favColor = UIColor(cgColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        static var nonFavColor = UIColor(cgColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    }
}

