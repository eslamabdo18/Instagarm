//
//  MainTabBarController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginView = logingViewController()
                let nanController = UINavigationController(rootViewController: loginView)
                nanController.modalPresentationStyle = .fullScreen
                self.present(nanController,animated: true,completion: nil)
            }
           
            return
        }
        
       setUpView()
    }
    
    func setUpView() {
        
        let layout = UICollectionViewFlowLayout()
        //Home
        let homeNavController = tempNavController(rootController: HomeController(collectionViewLayout: layout), image1: "home_unselected", image2: "home_selected")
        //search
        let searchNavController  = tempNavController(rootController: HomeController(collectionViewLayout: layout), image1: "search_unselected", image2: "search_selected")
        // like
        let likeNavController  = tempNavController(rootController: HomeController(collectionViewLayout: layout), image1: "like_unselected", image2: "like_selected")
        //addPhot
        let addNavController  = tempNavController(rootController: PhotoSelectorController(collectionViewLayout: layout), image1: "plus_unselected", image2: "plus_unselected")
        // UserProfile
        let  profilenavController = tempNavController(rootController: UserProfileController(collectionViewLayout: layout), image1: "profile_unselected", image2: "profile_selected")
        
        tabBar.tintColor = .black
        viewControllers = [homeNavController,
                           searchNavController,
                           addNavController,
                           likeNavController,
                           profilenavController]
        
        guard let items = tabBar.items else {return}
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func tempNavController(rootController:UIViewController,image1:String,image2:String)-> UINavigationController {
        let viewController = rootController
        let homeNavController  = UINavigationController(rootViewController: viewController)
        homeNavController.tabBarItem.image = UIImage(named:image1 )
        homeNavController.tabBarItem.selectedImage = UIImage(named: image2)
        
        return homeNavController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2{
            let layout = UICollectionViewFlowLayout()
            let photoSelector = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelector)
            navController.modalPresentationStyle = .fullScreen
            present(navController,animated: true,completion: nil)
            return false
        }
        return true
    }
}
