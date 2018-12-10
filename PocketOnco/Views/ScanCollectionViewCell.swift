//
//  ScanCollectionViewCell.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/8/18.
//

import UIKit
import expanding_collection

class ScanCollectionViewCell: BasePageCollectionCell {

   
  
    @IBOutlet weak var testLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        testLabel.layer.shadowRadius = 2
        testLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        testLabel.layer.shadowOpacity = 0.2
    }

}
