//
//  FireBaseUtilis.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/6/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUid(uid:String,completion: @escaping (User) -> ()){
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snap) in
                   guard let userDict = snap.value as? [String:Any] else{return}
                   let use = User(uid:uid,dict: userDict)
                   completion(use)
               }) { (err) in
                   print("failed to catch post:",err)
               }
    }
}
