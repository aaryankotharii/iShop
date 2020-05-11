//
//  imagePicker.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class imagePicker : NSObject{
    
    public typealias ImageClosure = (_ image: UIImage) -> Void
    
    public static let sharedInstance = imagePicker()
    
    var selectedImageCompletion: ImageClosure?
    weak var currentViewController: UIViewController?
    var imagePickerVC = UIImagePickerController()
    var alertController = UIAlertController()
    
     
    func imagePickerAlert(_ imageView: UIImageView, vc : UIViewController,completion: @escaping ImageClosure){

        currentViewController = vc
        selectedImageCompletion = completion

        //MARK: ImagePicker ActionSheet
        alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //MARK: Actions [Delete + PhotoLibrary + Camera + Cancel]
        let deleteAction = UIAlertAction(title: "Delete Photo", style: .destructive, handler: handleDeletePhoto(action:))
        let photoLibraryAction = UIAlertAction.init(title: "Choose Photo", style: .default, handler: handleChoosePhoto(action:))
        let cameraAction = UIAlertAction.init(title: "Take photo", style: .default, handler: handleCameraTapped(action:))
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: handleCancel(action:))
    
       //MARK: Add Actions
        
        if imageView.image != {
            alertController.addAction(deleteAction)
        }
              alertController.addAction(photoLibraryAction)
              alertController.addAction(cameraAction)
              alertController.addAction(cancelAction)
        
        

            vc.present(alertController, animated: true)
    }
    
    func handleDeletePhoto(action: UIAlertAction){
        
    }
    
    func handleChoosePhoto(action: UIAlertAction){
        print("PHOTO")
           presentImagePicker(.photoLibrary) /// Presents PhotoLibrary

       }
    
    func handleCameraTapped(action: UIAlertAction){
           presentImagePicker(.camera) /// Presents Camera

       }
    
    func handleCancel(action: UIAlertAction){
        alertController.dismiss(animated: true, completion: nil)
    }
    
    
    func presentImagePicker(_ source : UIImagePickerController.SourceType){
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = source
        imagePickerVC.allowsEditing = true
        currentViewController?.present(imagePickerVC, animated: true, completion: nil)
    }
    
}


//MARK:- UIImagePickerController Delegate Methods
extension imagePicker : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        selectedImageCompletion?(image)
        picker.dismiss(animated: true, completion: nil)
        imagePickerVC = UIImagePickerController()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled Image picker")
        picker.dismiss(animated: true, completion: nil)
    }
}
