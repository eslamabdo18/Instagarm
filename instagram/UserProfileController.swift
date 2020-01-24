//
//  UserProfileController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        fetchUser()
    }
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, string) in
            let dict = snapshot.value as? [String:Any]
            let username = dict?["username"] as? String
            self.navigationItem.title = username
        }) { (error) in
            print("failed to fetch data")
        }
    }
}
