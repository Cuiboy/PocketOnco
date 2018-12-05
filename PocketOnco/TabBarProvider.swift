//
//  TabBarProvider.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/4/18.
//

import UIKit
import ESTabBarController_swift
     let customTabBarController = ESTabBarController()

enum TabBars {
    
    static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> NavigationViewController {
   
        customTabBarController.delegate = delegate
        customTabBarController.title = "example"
        customTabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        customTabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
        customTabBarController.shouldHijackHandler = {
            customTabBarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        customTabBarController.didHijackHandler = {
            [weak customTabBarController] tabBarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
               tabBarController.present(alertController, animated: true, completion: nil)
            }
        }
        
        let v1 = PlaceHolderViewController()
        let v2 = PlaceHolderViewController()
        let v3 = PlaceHolderViewController()
        let v4 = PlaceHolderViewController()
        let v5 = PlaceHolderViewController()
        
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Info", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Develop", image: UIImage(named: "code"), selectedImage: UIImage(named: "code"))
        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "About", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        customTabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController = NavigationViewController.init(rootViewController: customTabBarController)
       
        return navigationController
    }
}
