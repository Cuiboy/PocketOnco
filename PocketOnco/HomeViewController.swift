//
//  HomeViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/5/18.
//

import UIKit
import Segmentio



class HomeViewController: UIViewController {

    @IBOutlet weak var segmentioView: Segmentio!
    var content = [SegmentioItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PocketOnco"
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        segmentioView.my_dropShadow()
        setSegmentedControl()
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
    
        segmentioView.valueDidChange = { segmentio, segmentIndex in
//            switch segmentIndex {
//
//            case 0:
//                self.current = self.articles
//            case 1:
//                self.current = self.groupDictionary["NEWS"] ?? []
//            case 2:
//                self.current = self.groupDictionary["OPINION"] ?? []
//            case 3:
//                self.current = self.groupDictionary["FEATURES"] ?? []
//            case 4:
//                self.current = self.groupDictionary["SHOWCASE"] ?? []
//            case 5:
//                self.current = self.groupDictionary["SPORTS"] ?? []
//            case 6:
//                self.current = self.groupDictionary["A&E"] ?? []
//            case 7:
//                self.current = self.groupDictionary["THE PAW PRINT"] ?? []
//            default:
//                print("more coming")
//            }
//            self.newsTableView.reloadData()
        }
        
    

}
    
    func setSegmentedControl() {
        
        let position = SegmentioPosition.fixed(maxVisibleItems: 3)
        let indicator = SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color:  UIColor(red:0.137, green:0.251, blue:0.345, alpha:1.00))
        let horizontal = SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.none)
        let vertical = SegmentioVerticalSeparatorOptions(ratio: 1, color: UIColor(white: 195/255, alpha: 0.75))
        segmentioView.selectedSegmentioIndex = 0
        let options = SegmentioOptions(backgroundColor: UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.00), segmentPosition: position, scrollEnabled: true, indicatorOptions: indicator, horizontalSeparatorOptions: horizontal, verticalSeparatorOptions: vertical, imageContentMode: .scaleAspectFit, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: (
            
            defaultState: SegmentioState(backgroundColor: UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.00), titleFont: UIFont(name: "Raleway-Bold", size: CGFloat(12).relativeToWidth)!, titleTextColor: UIColor(red:0.137, green:0.251, blue:0.345, alpha:1.00)),
            selectedState: SegmentioState(backgroundColor: UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.00), titleFont: UIFont(name: "Raleway-Bold", size: CGFloat(12).relativeToWidth)!, titleTextColor:  UIColor(red:0.137, green:0.251, blue:0.345, alpha:1.00)),
           
            highlightedState: SegmentioState(backgroundColor: UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.00), titleFont: UIFont(name: "Raleway-Bold", size: CGFloat(12).relativeToWidth)!, titleTextColor:  UIColor(red:0.137, green:0.251, blue:0.345, alpha:1.00))
            )
            ,animationDuration: 0.2)
        
        let all = SegmentioItem(title: "All", image: UIImage(named: "all"))
        let colon = SegmentioItem(title: "Colorectal", image: UIImage(named: "colon"))
        let breast = SegmentioItem(title: "Breast", image: UIImage(named: "breast"))
        let skin = SegmentioItem(title: "Skin", image: UIImage(named: "hair"))
        
        content = [all, colon, breast, skin]
        segmentioView.setup(content: content, style: .imageOverLabel, options: options)
        
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
