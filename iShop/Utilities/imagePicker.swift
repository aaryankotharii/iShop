//
//  imagePicker.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension UIViewController: UIImagePickerControllerDelegate{
    func imagePickerAlert(_ imageView: UIImageView){

        //MARK: ImagePicker ActionSheet
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //MARK: Actions [Delete + PhotoLibrary + Camera + Cancel]
        let deleteAction = UIAlertAction(title: "Delete Photo", style: .destructive, handler: handleDeletePhoto(action:))
        let photoLibraryAction = UIAlertAction.init(title: "Choose Photo", style: .default, handler: handleChoosePhoto(action:))
        let cameraAction = UIAlertAction.init(title: "Take photo", style: .default, handler: handleCameraTapped(action:))
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: handleCancel(action:))
    
        //MARK: Add Actions
//        if imageView.image != self.defaultImage{
//            alertController.addAction(deleteAction)
//        }
              alertController.addAction(photoLibraryAction)
              alertController.addAction(cameraAction)
              alertController.addAction(cancelAction)

            self.present(alertController, animated: true)
    }
    
    func handleDeletePhoto(action: UIAlertAction){
        
    }
    
    func handleChoosePhoto(action: UIAlertAction){
           
       }
    
    func handleCameraTapped(action: UIAlertAction){
           
       }
    
    func handleCancel(action: UIAlertAction){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
