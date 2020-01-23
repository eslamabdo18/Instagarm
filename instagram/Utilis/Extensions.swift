//
//  Extensions.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/22/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

extension UIColor{
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

