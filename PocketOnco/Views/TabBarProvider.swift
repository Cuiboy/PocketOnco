//
//  TabBarProvider.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/4/18.
//

import UIKit
import ESTabBarController_swift
import XLActionController

let customTabBarController = ESTabBarController()


enum TabBars {
    
    static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
   
        customTabBarController.delegate = delegate
        customTabBarController.title = "example"
        customTabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        customTabBarController.tabBar.backgroundImage = UIImage(named: "background-light")
        customTabBarController.shouldHijackHandler = {
            customTabBarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        customTabBarController.didHijackHandler = {
            [weak customTabBarController] tabBarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                let alertController = SkypeActionController()
       //         let selectTypeViewController = PickTypeViewController()
            
                alertController.backgroundColor = UIColor(red: 0.102, green: 0.255, blue: 0.353, alpha: 1.0)
                alertController.addAction(Action("Take a photo", style: .default, handler: { (action) in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "addImage")
                    HomeViewController.isOpen = true
                    PickTypeViewController.camera = true
                    customTabBarController?.selectedViewController!.present(vc, animated: true)
                }))
                    alertController.addAction(Action("Select from album", style: .default, handler: { (action) in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "addImage")
                         HomeViewController.isOpen = true 
                        PickTypeViewController.camera = false
                        customTabBarController?.selectedViewController!.present(vc, animated: true)
                    }))
                        
                alertController.addAction(Action("Cancel", style: .cancel, handler: { (action) in
                    //something happens
                }))
                
             
                customTabBarController?.selectedViewController!.present(alertController, animated: true, completion: nil)
             
                
            }
        }
        
        let v1 = HomeViewController()
//        let v2 = InfoViewController()
        let v3 = PlaceHolderViewController()
        let v4 = DevViewController()
//        let v5 = AboutViewController()
        
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
//        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Info", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Develop", image: UIImage(named: "code"), selectedImage: UIImage(named: "code"))
//        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "About", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
//
        customTabBarController.viewControllers = [v1, v3, v4].map {
            NavigationViewController.init(rootViewController: $0)
        }
        
      
       
        return customTabBarController
    }
}
