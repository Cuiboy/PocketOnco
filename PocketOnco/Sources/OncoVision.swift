//
//  TDScanner.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/8/18.
//

import Foundation
import UIKit
import CoreML
import Vision
import ImageIO
import GameplayKit



public enum tumorTypes {
    case colorectal
    case breast
    case skin
}



open class OncoVision {
    
    
    var finalOutput = [ImageAnalysis]()
    
    lazy var histopathRecognizerRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: histopathologyRecognizer().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var skinImageRecognizerRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: skinImageRecognizer().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                    self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var colonIdentificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Colon_NormalCancerousRecognizer().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                      self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var breastIdentificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Breast_NormalCancerousRecognizer().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                     self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var skinIdentificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Skin_NormalCancerousRecognizer().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                      self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var colonPrognosisRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Colon_BenignMalignant().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                     self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var colonClassificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Colon_StageGrade().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                     self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var breastClassificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Breast_StageGrade().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                     self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    lazy var skinClassificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Skin_Diagnosis().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                      self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    

    
    


    func identifyModels(type: tumorTypes) -> [VNRequest] {
        switch type {
        case .colorectal:
            return [histopathRecognizerRequest, colonIdentificationRequest, colonPrognosisRequest, colonClassificationRequest]
        case .breast:
            return [histopathRecognizerRequest, breastIdentificationRequest, breastClassificationRequest]
        case .skin:
            return [skinImageRecognizerRequest, skinIdentificationRequest]
        }
    }


    
    fileprivate func histopathRecognizer(for image: UIImage) {
       
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
               
                try handler.perform([self.histopathRecognizerRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
  
    fileprivate func skinRecognizer(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
         let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.skinImageRecognizerRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
    }
    fileprivate func colonIdentification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
    
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.colonIdentificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    fileprivate func breastIdentification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.breastIdentificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    fileprivate func skinIdentification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
       
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.skinIdentificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    
    fileprivate func colonPrognosis(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
       
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.colonPrognosisRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    fileprivate func colonClassification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
       
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.colonClassificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    fileprivate func  breastClassification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
      
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.breastClassificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    fileprivate func skinClassification(for image: UIImage) {
        
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
     
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation ?? .up)
            do {
                
                try handler.perform([self.skinClassificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        
    }
    
    fileprivate func processClassifications(for request: VNRequest, error: Error?)  {
        
      
        
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                self.finalOutput = []
                return
            }
   
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
               
                self.finalOutput = []
            } else {
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification -> ImageAnalysis in
                    let evaluation = ImageAnalysis()
                    evaluation.confidence = CGFloat(classification.confidence)
                    evaluation.label = classification.identifier
                 
                    return evaluation
                }
                self.finalOutput = descriptions
                
            }
            
        
      
        
    }
    
    open func analyse(for image: UIImage, with type: tumorTypes) -> (Bool, Analytics?) {

        let analyseOutput = Analytics()
       
        switch type {
        case .colorectal:
            histopathRecognizer(for: image)
            if self.finalOutput[0].label == "irrelevant" {
                return (false, nil)
            } else {
                colonIdentification(for: image)
                if self.finalOutput[0].label == "healthy" {
                    return (true, nil)
                } else {
                    colonClassification(for: image)
                    analyseOutput.cancerType = "Colorectal Cancer"
                    switch finalOutput[0].label {
                        case "adenomatous":
                            analyseOutput.cancerGrade = 0
                            analyseOutput.cancerStage = 1
                        case "moderately differentiated":
                            analyseOutput.cancerGrade = 2
                            analyseOutput.cancerStage = 2
                        case "moderately-to-poorly differentiated":
                            analyseOutput.cancerGrade = 2
                            analyseOutput.cancerStage = 2
                        case "poorly differentiated":
                            analyseOutput.cancerGrade = 3
                            analyseOutput.cancerStage = 3
                        default:
                            print("something wrong happened")
                            break
                    }
                    
                return (true, analyseOutput)
                    
  
                }
            }
        case .breast:
            histopathRecognizer(for: image)
            if self.finalOutput[0].label == "irrelevant" {
                return (false, nil)
            } else {
                breastIdentification(for: image)
                if self.finalOutput[0].label == "healthy" {
                    return (true, nil)
                } else {
                    breastClassification(for: image)
                   analyseOutput.cancerType = "Breast Cancer"
                    switch finalOutput[0].label {
                    case "Benign":
                        analyseOutput.cancerGrade = 1
                        analyseOutput.cancerStage = 0
                    case "InSitu":
                        analyseOutput.cancerGrade = 0
                        analyseOutput.cancerStage = 1
                    case "Invasive":
                        analyseOutput.cancerGrade = 3
                        analyseOutput.cancerStage = 2
                    default:
                        print("something wrong happened")
                        break
                    }

                    return (true, analyseOutput)
                   
                }
            }
        case .skin:
            skinRecognizer(for: image)
            if self.finalOutput[0].label == "irrelevant" {
                return (false, nil)
            } else {
                skinIdentification(for: image)
                if self.finalOutput[0].label == "healthy" {
                    return (true, nil)
                } else {
                    skinClassification(for: image)
                    switch finalOutput[0].label {
                    case "MEL":
                        analyseOutput.cancerType = "Melanoma"
                    case "NV":
                         analyseOutput.cancerType = "Malanocytic Nevus"
                    case "BCC":
                         analyseOutput.cancerType = "Basal Cell Carcinoma"
                    case "AKIEC":
                         analyseOutput.cancerType = "Actinic Keratosis"
                    case "BKL":
                         analyseOutput.cancerType = "Benign Keratosis"
                    case "DF":
                         analyseOutput.cancerType = "Dermatofibroma"
                    case "VASC":
                         analyseOutput.cancerType = "Vascular Lesion"
                    default:
                        print("something wrong happened")
                        break
                        
                    }
                    return (true, analyseOutput)
                }
            }
        }
      
    
       
    }
    
}
   
    

