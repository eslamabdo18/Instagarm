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
    
    var posts = [Post]()
    let cellID = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        guard let uid = Auth.auth().currentUser?.uid else {return}
        navigationItem.title = uid
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView.register(ProfilePhotoCell.self, forCellWithReuseIdentifier: cellID)
        
        setupLogOut()
        
        fetchOrderdPosts()
    }
    func fetchOrderdPosts(){
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("posts").child(userId)
        ref.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String:Any] else {return}
            guard let user = self.user else {return}
            let post = Post(user:user,dict: dict)
            self.posts.insert(post, at: 0)
            self.collectionView.reloadData()
            
        }) { (err) in
            print("failed to fetch post",err)
        }
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
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProfilePhotoCell
        
         cell.post = posts[indexPath.item]
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
        Database.fetchUserWithUid(uid: uid) { (user) in

            self.user = user
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
        }
    }
}


