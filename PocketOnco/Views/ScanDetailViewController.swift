//
//  ScanDetailViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/9/18.
//

import UIKit
import CoreData
import Presentr

class ScanDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let presenter: Presentr = {
        let presenter = Presentr(presentationType: .popup)
        presenter.transitionType = TransitionType.coverHorizontalFromRight
        presenter.dismissOnSwipe = true
        return presenter
    }()
    
    lazy var popup: PopUpTreatmentViewController = {
        let popupViewController = self.storyboard?.instantiateViewController(withIdentifier: "popup")
        return popupViewController as! PopUpTreatmentViewController
    }()
    
    @objc func popupDefault() {
        presenter.presentationType = .popup
        presenter.transitionType = nil
        presenter.dismissTransitionType = nil
        presenter.dismissAnimated = true
        customPresentViewController(presenter, viewController: popup, animated: true)
    }

    @IBAction func saveTapped(_ sender: Any) {
       let tumorObject = Tumor(context: PersistentService.context)
        tumorObject.setValue(name, forKey: "type")
        tumorObject.setValue(type.text, forKey: "name")
        let imageData = NSData(data: tumorImage.pngData()!)
        tumorObject.setValue(imageData, forKey: "image")
        
        if tumor != nil {
            tumorObject.setValue(false, forKey: "isHealthy")
            tumorObject.setValue(tumor!.cancerStage, forKey: "stage")
            tumorObject.setValue(tumor!.cancerGrade, forKey: "grade")
         
        } else {
            tumorObject.setValue(true, forKey: "isHealthy")
            
        }
        
        PersistentService.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func discardTapped(_ sender: Any) {
        if ScanDetailViewController.isPresenting {
            dismiss(animated: true)
        } else {
            let ac = UIAlertController(title: "Discard Image?", message: "Your image will not be saved.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(ac, animated: true)
        }
       
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var primaryInfo: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var imageOutlineView: UIView!
    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var leftButtonView: UIView!
    @IBOutlet weak var rightButtonView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var tumor: Analytics?
    static var isHealthy = Bool()
    static var isPresenting = Bool()
    var tumorImage = UIImage()
    var tumorType: tumorTypes?
    let stages = ["I", "II", "III"]
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Analytics"
        switch tumorType {
        case .colorectal?:
            illustration.image = UIImage(named: "colon")
            name = "Colorectal"
        case .breast?:
            illustration.image = UIImage(named: "breast")
            name = "Breast"
        case .skin?:
            illustration.image = UIImage(named: "hair")
            name = "Skin"
        default: break
            
        }
        imageView.image = tumorImage
        if tumor != nil {
             primaryInfo.text = "TUMOR DETECTED"
            if tumor!.cancerType == "Melenoma" || tumor!.cancerType == "Breast Cancer" || tumor!.cancerType == "Colorectal Cancer" {
                
                let leftRecognizer = UITapGestureRecognizer(target: self, action: #selector(treatmentTapped))
                leftRecognizer.delegate = self
                leftButtonView.addGestureRecognizer(leftRecognizer)
                
                let rightRecognizer = UITapGestureRecognizer(target: self, action: #selector(clinicalTapped))
                rightRecognizer.delegate = self
                rightButtonView.addGestureRecognizer(rightRecognizer)
            } else {
                leftButtonView.isHidden = true
                rightButtonView.isHidden = true
                
            }
            
            if tumor!.cancerType == "Breast Cancer" || tumor!.cancerType == "Colorectal Cancer" {
                if let stageNumber = tumor!.cancerStage {
                    if stageNumber > 0 {
                        type.text = "Stage \(stages[stageNumber - 1]) \(name) Cancer"
                    } else if tumor!.cancerStage == 0 {
                        type.text = "Stage 0 \(name) Cancer"
                    }
                }
                if let gradeNumber = tumor!.cancerGrade {
                    grade.text = "Grade: \(gradeNumber)"
                } else {
                    grade.text = "Grade: X"
                }
            } else {
                type.text = tumor!.cancerType
                grade.text = "Grade: X"
            }
            
           
           
           
          
          
        } else {
           primaryInfo.text = "HEALTHY"
            primaryInfo.textColor = lightColor
            type.text = "Healthy \(name) Tissue"
            grade.text = "Grade: N/A"
            
            
            
        }
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageOutlineView.layer.cornerRadius = imageOutlineView.frame.height / 2
        imageOutlineView.layer.borderWidth = 2
        imageOutlineView.layer.borderColor = darkColor.cgColor
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
       
      
        if tumor != nil {
            leftButtonView.layer.cornerRadius = leftButtonView.frame.height / 2
            leftButtonView.layer.borderWidth = 2
            leftButtonView.layer.borderColor = darkColor.cgColor
            rightButtonView.layer.cornerRadius = rightButtonView.frame.height / 2
            rightButtonView.layer.borderWidth = 2
            rightButtonView.layer.borderColor = darkColor.cgColor
        } else {
      
            leftButtonView.isHidden = true
            rightButtonView.isHidden = true
            leftLabel.isHidden = true
            rightLabel.isHidden = true
        }
    }
    
    @objc func treatmentTapped() {
        PopUpTreatmentViewController.type = tumor!.cancerType
        PopUpTreatmentViewController.name = type.text?.capitalized ?? "TREATMENT"
        if let stage = tumor!.cancerStage {
            PopUpTreatmentViewController.stage = stage
        } else {
            PopUpTreatmentViewController.stage = nil
        }
        popupDefault()
    }
    
    @objc func clinicalTapped() {
        performSegue(withIdentifier: "clinical", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clinical" {
            if let vc = segue.destination as? ClinicalTrialsViewController {
                vc.name = tumor!.cancerType
            }
        }
    }
 
}
