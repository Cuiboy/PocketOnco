//
//  ScanCollectionViewCell.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/8/18.
//

import UIKit
import expanding_collection
import CoreData

class ScanCollectionViewCell: BasePageCollectionCell, UIGestureRecognizerDelegate  {

   
  
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeDetailLabel: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var viewLabelY: NSLayoutConstraint!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var moreInfoImageView: UIImageView!
    
    @IBOutlet weak var maskCover: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView?.alpha = 0.2
        testLabel.layer.shadowRadius = 2
        testLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        testLabel.layer.shadowOpacity = 0.2
        rightView.layer.cornerRadius = rightView.frame.width / 2
        leftView.layer.cornerRadius = leftView.frame.width / 2
        rightView.layer.borderWidth = 1.5
        leftView.layer.borderWidth = 1.5
        rightView.layer.borderColor = UIColor.white.cgColor
        leftView.layer.borderColor = UIColor.white.cgColor
        frontContainerView.layer.shadowOpacity = 0.1
        
        let trashRecognizer = UITapGestureRecognizer(target: self, action: #selector(trashTapped))
        trashRecognizer.delegate = self
        leftView.addGestureRecognizer(trashRecognizer)
        
        let moreRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreTapped))
        moreRecognizer.delegate = self
        rightView.addGestureRecognizer(moreRecognizer)
    }

    @objc func trashTapped() {
        let ac = UIAlertController(title: "Delete this scan?", message: "This action cannot be undone.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            NotificationCenter.default.post(Notification(name: Notification.Name("trash")))
          
            
        }))
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.parentViewController?.present(ac, animated: true)
    }
   
    @objc func moreTapped() {
        NotificationCenter.default.post(Notification(name: Notification.Name("more")))
    }
    
    
}
