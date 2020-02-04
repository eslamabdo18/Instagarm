//
//  CustomImageView.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/4/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class CustomImageView:UIImageView{
    
    var lastUrl:String?
    func loadImage(urlString:String){
        
        lastUrl = urlString
              guard let url = URL(string: urlString) else {return}
                 URLSession.shared.dataTask(with: url) { (data, response, error) in
                  if let error = error {
                      print("failed to fetch image",error)
                  }
                    if url.absoluteString != self.lastUrl{
                      return
                  }
                  guard let imageData = data else {return}
                   let image = UIImage(data: imageData)
                   DispatchQueue.main.async {
                       self.image = image
                   }

                 }.resume()
    }
}
