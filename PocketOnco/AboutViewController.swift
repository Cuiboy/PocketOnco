//
//  AboutViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/5/18.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        switch customTabBarController.selectedIndex {
        case 2:
            break
        case 0, 1, 3, 4:
          break
        default: break
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
