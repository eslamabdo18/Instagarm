//
//  MainTabBarController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let profileController = UserProfileController(collectionViewLayout: layout)
        let  navController = UINavigationController(rootViewController: profileController)
       

        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        viewControllers = [navController]
    }
}
