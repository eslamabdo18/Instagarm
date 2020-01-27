//
//  MainTabBarController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginView = logingViewController()
                let nanController = UINavigationController(rootViewController: loginView)
//                loginView.modalPresentationStyle = .fullScreen
                nanController.modalPresentationStyle = .fullScreen
                self.present(nanController,animated: true,completion: nil)
            }
           
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        let profileController = UserProfileController(collectionViewLayout: layout)
        let  navController = UINavigationController(rootViewController: profileController)
       

        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        viewControllers = [navController]
    }
}
