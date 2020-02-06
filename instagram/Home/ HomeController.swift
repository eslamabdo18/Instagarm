//
//  HomeController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/28/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase
class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var cellId = "cellId"
    var user:User?
    var posts = [Post]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNav()
        fetchPosts()
    }
    func fetchPosts(){
        guard let userId = Auth.auth().currentUser?.uid else {return}
       
        Database.fetchUserWithUid(uid: userId) { (user) in
            self.fetchPostsWithUser(user: user)
        }
    }
    func fetchPostsWithUser(user:User){
        
        let ref = Database.database().reference().child("posts").child(user.userId)
                          ref.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, string) in
                              
                              guard let dict = snapshot.value as? [String:Any] else{return}
                              dict.forEach { (key,value) in
                                  guard let valuesDict = value as? [String:Any] else{return}
                                  let post = Post(user:user,dict: valuesDict)
                                  self.posts.append(post)
                                 
                              }
                           self.collectionView.reloadData()
               }) { (err) in
                   print(err)
               }
    }
    func setupNav(){
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 40+8+8
        height += view.frame.width
        height += 50
        height += 40
        return CGSize(width: view.frame.width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
}
