//
//  User.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/4/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import Foundation

struct User {
    let username:String
    let image:String
    let userId:String
    
    init(uid:String,dict:[String:Any]) {
        self.username = dict["username"] as? String ?? ""
        self.image = dict["profileImageURL"] as? String ?? ""
        self.userId = uid
    
    }
}
