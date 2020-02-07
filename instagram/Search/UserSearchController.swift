//
//  UserSearchController.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/6/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase

class UserSearchController:UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    
    var filterdUsers = [User]()
    var users = [User]()
    lazy var searchBar:UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter Username"
        sb.delegate = self
        return sb
    }()
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let nav = navigationController?.navigationBar
        searchBar.Anchor(top: nav?.topAnchor, left: nav?.leftAnchor, bottom: nav?.bottomAnchor, right: nav?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, height: 0, width: 0)
        
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchUsers()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            filterdUsers = users
        }else{
            
            filterdUsers = users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
       
        collectionView.reloadData()
    }
    func fetchUsers(){
        
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snap, string) in
            guard let dicts = snap.value as? [String:Any] else {return}
            
            dicts.forEach { (key,value) in
                guard let userDict = value as? [String:Any] else {return}
                let user = User(uid: key, dict: userDict)
                self.users.append(user)
            }
            self.users.sort { (u1, u2) -> Bool in
                
                return u1.username.compare(u2.username) == .orderedAscending
            }
            self.filterdUsers = self.users
            self.collectionView.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterdUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!UserSearchCell
        
        cell.user = filterdUsers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}
