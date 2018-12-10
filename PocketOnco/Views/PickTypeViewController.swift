//
//  PickTypeViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/8/18.
//

import UIKit
import ViewAnimator
import ALCameraViewController

class PickTypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    let images = [
    UIImage(named: "colon"),
    UIImage(named: "breast"),
    UIImage(named: "hair")
    ]
    let names = ["Colorectal", "Breast", "Skin"]
   
    static var camera = Bool()
    
    var type: tumorTypes?
    var selectedImage = UIImage()

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var typeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PickTypeViewController.camera)
        title = "Choose Cancer Type"
        let nib = UINib(nibName: "PickTypeCollectionViewCell", bundle: nil)
        typeCollectionView.register(nib, forCellWithReuseIdentifier: "type")
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self 
        let layout = self.typeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: CGFloat(50).relativeToWidth, bottom: 0, right: CGFloat(50).relativeToWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = CGFloat(30).relativeToWidth
        layout.itemSize = CGSize(width: typeCollectionView.frame.width * 0.45, height: typeCollectionView.frame.width * 0.605)
        
      
    }

    func configureCells() {
        
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

extension PickTypeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type", for: indexPath) as! PickTypeCollectionViewCell
        cell.typeImage.image = images[indexPath.item]
        cell.name.text = names[indexPath.item]
        
        cell.circle.clipsToBounds = true
        cell.circle.layer.cornerRadius = cell.frame.width * 0.9 / 2
        cell.circle.layer.borderWidth = 2
        cell.circle.layer.borderColor = UIColor(red: 0.102, green: 0.255, blue: 0.353, alpha: 1.0).cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = typeCollectionView.visibleCells[indexPath.item] as! PickTypeCollectionViewCell
        if cell.name.text == "Colorectal" {
         
            type = tumorTypes.breast
        } else if cell.name.text == "Breast" {
           
            type = tumorTypes.colorectal
        } else if cell.name.text == "Skin" {
   
            type = tumorTypes.skin
        }
       
        if PickTypeViewController.camera {

            let croppingParameters = CroppingParameters(isEnabled: true, allowResizing: true, allowMoving: true, minimumSize: CGSize(width: 60, height: 60))
            let cameraViewController = CameraViewController.init(croppingParameters: croppingParameters, allowsLibraryAccess: true, allowsSwapCameraOrientation: true, allowVolumeButtonCapture: true) { [weak self] image, asset in
                if image != nil {
                    self?.selectedImage = image!

                    self?.performSegue(withIdentifier: "imagePreview", sender: nil)
                }
                self?.dismiss(animated: true, completion: nil)
            }

            present(cameraViewController, animated: true)
        } else {
            let imagePickerViewController = CameraViewController.imagePickerViewController(croppingParameters: CroppingParameters(isEnabled: true, allowResizing: true, allowMoving: true, minimumSize: CGSize(width: 60, height: 60))) { [weak self] image, asset in
                if image != nil {
                    self?.selectedImage = image!
                 print("The type just as I clicked is \(self?.type)")
                    self?.performSegue(withIdentifier: "imagePreview", sender: nil)
                }
                self?.dismiss(animated: true, completion: nil)
            }
            present(imagePickerViewController, animated: true)

        }
    
    }
    
}


extension PickTypeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imagePreview" {
            if let vc = segue.destination as? ImagePreviewViewController {
                vc.image = selectedImage
                vc.type = type
                
            }
        }
    }
}



