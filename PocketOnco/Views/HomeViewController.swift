//
//  HomeViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/5/18.
//

import UIKit
import Segmentio
import expanding_collection
import CoreData



class HomeViewController: ExpandingViewController, UICollectionViewDelegateFlowLayout {

    static var isOpen = false
    @IBOutlet weak var noScanLabel: UILabel!
    @IBOutlet weak var segmentioView: Segmentio!
    var content = [SegmentioItem]()
    var pastScans = [TumorScan]()
    var colorectalScans = [TumorScan]()
    var breastScans = [TumorScan]()
    var skinScans = [TumorScan]()
    
    override func viewDidLoad() {

        self.view.backgroundColor = UIColor.init(white: 195/255, alpha: 1)
        super.viewDidLoad()
        title = "PocketOnco"
        let nib = UINib(nibName: "ScanCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "scanCell")
       
        fetchData(isNew: false)
       
        NotificationCenter.default.addObserver(self, selector: #selector(deleteObject), name: Notification.Name("trash"), object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(more), name: Notification.Name("more"), object: nil)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        segmentioView.my_dropShadow()
        

          itemSize = CGSize(width: CGFloat(250).relativeToWidth, height: CGFloat(275).relativeToWidth)
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsets.init(top: 50, left: CGFloat(0).relativeToWidth, bottom: 0, right: CGFloat(0).relativeToWidth)
        
        
       
        
    }

    func fetchData(isNew: Bool) {
        let fetchRequest: NSFetchRequest<Tumor> = Tumor.fetchRequest()
        do {
            let request = try PersistentService.context.fetch(fetchRequest)
            if request.count > 0 {
                noScanLabel.isHidden = true
                if isNew {
                    let items = request.last!
                    let newItem = TumorScan()
                    let imageData = Data(referencing: items.image!)
                    newItem.image = UIImage(data: imageData)!
                    newItem.type = items.type ?? "N/A"
                    newItem.name = items.name ?? "N/A"
                    if items.isHealthy {
                        newItem.grade = nil
                        newItem.stage = nil
                        
                    } else {
                        newItem.grade = Int(items.grade)
                        newItem.stage = Int(items.stage)
                    }
                    pastScans.append(newItem)
                    generateSubArrays()
                    
                } else {
                    for items in request {
                        let newItem = TumorScan()
                        let imageData = Data(referencing: items.image!)
                        newItem.image = UIImage(data: imageData)!
                        newItem.type = items.type ?? "N/A"
                        newItem.name = items.name ?? "N/A"
                        if items.isHealthy {
                            newItem.grade = nil
                            newItem.stage = nil
                            
                        } else {
                            newItem.grade = Int(items.grade)
                            newItem.stage = Int(items.stage)
                        }
                        pastScans.append(newItem)
                        generateSubArrays()
                        
                    }
                }
                
                
            } else {
                noScanLabel.isHidden = false
            }
            
            
        } catch {
            
        }
    }
    
    func generateSubArrays() {
        colorectalScans = pastScans.filter {
            $0.type == "Colorectal"
        }
        breastScans = pastScans.filter {
            $0.type == "Breast"
        }
        skinScans = pastScans.filter {
            $0.type == "Skins"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
              setSegmentedControl()
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
        
    }
   
    override func viewDidAppear(_ animafted: Bool) {
        super.viewDidAppear(true)
        
        if HomeViewController.isOpen {
            fetchData(isNew: true)
             collectionView?.reloadData()
            HomeViewController.isOpen = false
            }
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
           
            self.collectionView?.reloadData()
        }
      
        switch customTabBarController.selectedIndex {
        case 2:
            break
        case 0, 1, 3, 4:
           break
        default: break
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
    
    @objc func more() {
        if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? NavigationViewController {
            if let vc = nc.viewControllers.first as? ScanDetailViewController {
                var item = TumorScan()
                switch segmentioView.selectedSegmentioIndex {
                case 0:
                    item = pastScans[currentIndex]
                case 1:
                    item = colorectalScans[currentIndex]
                case 2:
                    item = breastScans[currentIndex]
                case 3:
                    item = skinScans[currentIndex]
                default: break
                }
                let passedResult = Analytics()
                passedResult.cancerStage = item.stage
                passedResult.cancerGrade = item.grade
                passedResult.cancerType = "\(item.type) Cancer"
               
                vc.tumor = passedResult
                
                
                vc.tumorImage = item.image
                switch item.type {
                case "Colorectal":
                    vc.tumorType = tumorTypes.colorectal
                case "Breast":
                    vc.tumorType = tumorTypes.breast
                case "Skin":
                    vc.tumorType = tumorTypes.skin
                default: break
                }
                
               ScanDetailViewController.isPresenting = true 
            }
             present(nc, animated: true)
        }
    }
    
    @objc func deleteObject() {
        let cell = collectionView?.visibleCells[currentIndex]
        UIView.animate(withDuration: 0.5, animations: {
            cell?.alpha = 0
        }) { (_) in
            let fetchRequest: NSFetchRequest<Tumor> = Tumor.fetchRequest()
            if let result = try? PersistentService.context.fetch(fetchRequest) {
              
                PersistentService.context.delete(result[self.currentIndex])
                
//                self.collectionView?.deleteItems(at: [IndexPath(item: self.currentIndex, section: 0)])
                self.pastScans.remove(at: self.currentIndex)
                self.generateSubArrays()
                switch self.segmentioView.selectedSegmentioIndex {
                case 0:
                    if self.pastScans.count == 0 {
                        self.noScanLabel.isHidden = false
                    }
                case 1:
                    if self.colorectalScans.count == 0 {
                        self.noScanLabel.isHidden = false
                    }
                case 2:
                    if self.breastScans.count == 0 {
                        self.noScanLabel.isHidden = false
                    }
                case 3:
                    if self.skinScans.count == 0 {
                        self.noScanLabel.isHidden = false
                    }
                default:
                    if self.pastScans.count == 0 {
                        self.noScanLabel.isHidden = false
                    }
                }
                
            }
            PersistentService.saveContext()
        }
        
        
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

extension HomeViewController {
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        var finalCount = pastScans.count
       
        switch segmentioView.selectedSegmentioIndex {
        case 0:
            finalCount = self.pastScans.count
        case 1:
            finalCount = self.colorectalScans.count
        case 2:
            finalCount =  self.breastScans.count
        case 3:
            finalCount =  self.skinScans.count
        default:
            finalCount =  self.pastScans.count
        }
        
        if finalCount == 0 {
            noScanLabel.isHidden = false
        } else {
             noScanLabel.isHidden = true
        }

   
        return finalCount
     
    }
    override func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> ScanCollectionViewCell {
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "scanCell", for: indexPath) as! ScanCollectionViewCell
        var item = TumorScan()
        switch segmentioView.selectedSegmentioIndex {
        case 0:
            item = pastScans[indexPath.item]
        case 1:
           item = colorectalScans[indexPath.item]
        case 2:
           item = breastScans[indexPath.item]
        case 3:
            item = skinScans[indexPath.item]
        default:
            item = pastScans[indexPath.item]
        }
        
        
        cell.mainImage.image = item.image
       cell.typeLabel.text = "\(item.type) Tissue".uppercased()
        if item.stage == nil {
            cell.typeDetailLabel.text = "Healthy"
        } else {
            cell.typeDetailLabel.text = "Tumor Detected"
        }
        if item.stage != nil {
            cell.stageLabel.text = "Stage: \(item.stage!)"
            
        } else {
            cell.typeLabel.text = "Stage: N/A"
        }
        
        if item.grade != nil {
             cell.gradeLabel.text = "Grade: \(item.grade!)"
        } else {
            cell.gradeLabel.text = "Grade: X"
        }
       
        return cell
       
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ScanCollectionViewCell , currentIndex == indexPath.row else {return}
    
        if cell.isOpened {
            UIView.animate(withDuration: 0.5) {
                cell.viewLabelY.constant = 0
                 cell.maskCover.backgroundColor = lightColor
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                
                cell.viewLabelY.constant = -50
                cell.maskCover.backgroundColor = darkColor
            }
            
        }
        cell.cellIsOpen(!cell.isOpened)
       
    }
}
