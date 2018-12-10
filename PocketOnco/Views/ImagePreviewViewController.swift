//
//  ImagePreviewViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/8/18.
//

import UIKit
import NVActivityIndicatorView

class ImagePreviewViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discardButton: UIBarButtonItem!
    var image = UIImage()
    var type: tumorTypes?
    var endResult: Analytics?
    var name = String()
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var analyseLabel: UILabel!
    @IBAction func discardTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Discard Image?", message: "Your image will not be saved.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preview"
        analyseLabel.textColor = darkColor
        typeLabel.textColor = darkColor
        imageView.image = image
        if type != nil {
            
            switch type {
            case .colorectal?:
                name = "colorectal"
            case .breast?:
                name = "breast"
            case .skin?:
                name = "skin"
            default:
                name = ""
            }
            typeLabel.text = "type: \(name) cancer"
        } else {
            typeLabel.text = ""
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(analyseTapped))
        recognizer.delegate = self
        buttonView.addGestureRecognizer(recognizer)
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        buttonView.layer.borderWidth = 2
        buttonView.layer.borderColor = darkColor.cgColor
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true 
        imageView.roundCornersForAspectFit(radius: 20)
        imageView.my_dropShadow()
        buttonView.my_dropShadow()
    }
    
    @objc func analyseTapped() {
       discardButton.isEnabled = false
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(origin: CGPoint(x: self.view.center.x - CGFloat(50).relativeToWidth, y: self.view.center.y - CGFloat(50).relativeToWidth), size: CGSize(width: CGFloat(100).relativeToWidth, height: CGFloat(100).relativeToWidth)), type: NVActivityIndicatorType(rawValue: 30), color: UIColor.white, padding: nil)
          let grayView = UIView()
        activityIndicator.alpha = 0
        grayView.alpha = 0
        grayView.bounds = UIScreen.main.bounds
        grayView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        grayView.backgroundColor = darkColor
        view.addSubview(grayView)
        view.addSubview(activityIndicator)
        UIView.animate(withDuration: 0.5) {
            grayView.alpha = 0.85
            activityIndicator.alpha = 1
            self.buttonView.backgroundColor = UIColor.init(white: 165/255, alpha: 0.5)
        }
        UIView.animate(withDuration: 0.3, delay: 1.2, options: [], animations: {
            self.buttonView.backgroundColor = UIColor.white
        }, completion: nil)
        
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        
          let result = OncoVision().analyse(for: self.image, with: .breast)
            if !result.0 {
                let ac = UIAlertController(title: "Invalid Image", message: "Please select a valid histopathology or skin image.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(ac, animated: true)
            } else {
                if result.1 == nil {
                    ScanDetailViewController.isHealthy = true
                    self.endResult = nil
                    self.performSegue(withIdentifier: "finishAnalytics", sender: nil)
                } else {
                    ScanDetailViewController.isHealthy = false
                    self.endResult = result.1
                     self.performSegue(withIdentifier: "finishAnalytics", sender: nil)
                }
            }
            
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishAnalytics" {
            if let vc = segue.destination as? ScanDetailViewController {
                vc.tumor = self.endResult
                vc.tumorImage = self.image
                vc.tumorType = self.type
            }
        }
    }
 

}
