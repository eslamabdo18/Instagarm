//
//  UserProfileController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        guard let uid = Auth.auth().currentUser?.uid else {return}
        navigationItem.title = uid
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        setupLogOut()
    }
    fileprivate func setupLogOut(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: UIImage(named: "gear"), style: .plain, target: self, action: #selector(logOut))
    }
    @objc func logOut() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "logout", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                let loginController = logingViewController()
                let nav = UINavigationController(rootViewController: loginController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }catch let err{
                print("failed to signout:",err)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        present(alertController,animated: true,completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as? UserProfileHeader
        
        header?.user = self.user
        
        return header!
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-2)/3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    var user:User?
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, string) in
            guard let dict = snapshot.value as? [String:Any] else{return}
            self.user = User(dict:dict)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
        }) { (error) in
            print("failed to fetch data")
        }
    }
}

struct User {
    let username:String
    let image:String
    
    init(dict:[String:Any]) {
        self.username = dict["username"] as? String ?? ""
        self.image = dict["profileImageURL"] as? String ?? ""
    }
}
