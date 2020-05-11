//
//  imagePicker.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class imagePicker : NSObject{
    
    public typealias VoidClosure = () -> Void
    public typealias ImageClosure = (_ image: UIImage) -> Void
    
    public static let sharedInstance = imagePicker()
    
    var selectedImageCompletion: ImageClosure?
    weak var currentViewController: UIViewController?
    var imagePickerVC = UIImagePickerController()
    var alertController = UIAlertController()
    
    var image : UIImage?
    
     
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
//        if imageView.image != self.defaultImage{
//            alertController.addAction(deleteAction)
//        }
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


extension imagePicker : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        selectedImageCompletion?(image)
        self.image = image
        picker.dismiss(animated: true, completion: nil)
        imagePickerVC = UIImagePickerController()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled Image picker")
        picker.dismiss(animated: true, completion: nil)
    }
}




//public class ImagePickerHelper: NSObject {
//
//    public typealias VoidClosure = () -> Void
//    public typealias ImageClosure = (_ image: UIImage) -> Void
//
//    /// 单例对象
//    public static let sharedInstance = ImagePickerHelper()
//
//    var selectedImageCompletion: ImageClosure?
//    weak var currentViewController: UIViewController?
//    var imagePickerVC = UIImagePickerController()
//
//    //MARK: Public Method
//
//    /// 使用 ActionSheet 显示 相机/照片 选项
//    ///
//    /// - Parameters:
//    ///   - title: ActionSheet 显示的标题
//    ///   - message: ActionSheet 显示的信息
//    ///   - controller: 当前需要显示 ActionSheet 的 Controller
//    ///   - completion: 选择照片完成后执行的 Closure
//    public func showObtainPhotoOptionSheet(withTipsTitle title: String, message: String, controller: UIViewController, completion: @escaping ImageClosure) {
//        currentViewController = controller
//        selectedImageCompletion = completion
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        alertVC.addAction(cancel)
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let camera = UIAlertAction(title: "相机", style: .default) { (action) in
//                self.cameraPermissions(deniedClosure: nil)
//            }
//            alertVC.addAction(camera)
//        }
//
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let photoLibrary = UIAlertAction(title: "相册", style: .default) { (action) in
//                self.photoAlbumPermissions()
//            }
//            alertVC.addAction(photoLibrary)
//        }
//        controller.present(alertVC, animated: true, completion: nil)
//    }
//
//    /// 打开照片
//    ///
//    /// - Parameters:
//    ///   - controller: 负责 present UIImagePickerController(.photoLibrary) 的 Controller
//    ///   - completion: 选择照片完成后执行的 Closure
//    public func showPhotoLibrary(byController controller: UIViewController, completion: @escaping ImageClosure) {
//        currentViewController = controller
//        selectedImageCompletion = completion
//        photoAlbumPermissions()
//    }
//
//
//    /// 打开相机
//    ///
//    /// - Parameters:
//    ///   - controller: 负责 present UIImagePickerController(.camera) 的 Controller
//    ///   - completion: 选择照片完成后执行的 Closure
//    public func showCamera(byController controller: UIViewController, completion: @escaping ImageClosure) {
//        currentViewController = controller
//        selectedImageCompletion = completion
//        cameraPermissions(deniedClosure: nil)
//    }
//
//    //MARK: Check photo permission
//    /// 检查相册权限，notDetermined：请求相册权限m，authorized：直接打开相册, 被拒绝则弹窗提示
//    ///
//    /// - Parameters:
//    ///   - callSystemImagePicker: 是否使用系统的相册图库来选择图片
//    ///   - authorizedClosure: 权限验证成功后执行的 Closure
//    ///   - deniedClosure: 权限被拒绝后执行的 Closure
//    public func photoAlbumPermissions(callSystemImagePicker: Bool = true, authorizedClosure: @escaping VoidClosure = {}, deniedClosure: @escaping VoidClosure = {}) {
//        let authStatus = PHPhotoLibrary.authorizationStatus()
//
//        if authStatus == .notDetermined {
//            PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) -> Void in
//                self.photoAlbumPermissions(authorizedClosure: authorizedClosure, deniedClosure: deniedClosure)
//            }
//        } else if authStatus == .authorized  {
//            authorizedClosure()
//            if callSystemImagePicker {
//                showPhotoPickerController(sourceType: .photoLibrary)
//            }
//        } else {
//            deniedClosure()
//        }
//    }
//
//    //MARK: Private Method
//    //MARK: Check camera permission
//
//    /// 相机的权限验证
//    ///
//    /// - Parameter deniedClosure: 权限被拒绝后执行的 Closure
//    private func cameraPermissions(deniedClosure: VoidClosure?) {
//        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//
//        if authStatus == .notDetermined {
//            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
//                self.cameraPermissions(deniedClosure: deniedClosure)
//            })
//        } else if authStatus == .authorized {
//            showPhotoPickerController(sourceType: .camera)
//        } else {
//            deniedClosure?()
//        }
//    }
//
//    /// 显示 UIImagePickerController
//    ///
//    /// - Parameter sourceType: UIImagePickerController.SourceType: (photoLibrary || camera || savedPhotosAlbum)
//    private func showPhotoPickerController(sourceType: UIImagePickerController.SourceType) {
//        imagePickerVC.delegate = self
//        imagePickerVC.sourceType = sourceType
//        imagePickerVC.allowsEditing = true
//        currentViewController?.present(imagePickerVC, animated: true, completion: nil)
//    }
//}
//
//extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.editedImage] as? UIImage else {
//            return
//        }
//        selectedImageCompletion?(image)
//        picker.dismiss(animated: true, completion: nil)
//        imagePickerVC = UIImagePickerController()
//    }
//
//    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//        imagePickerVC = UIImagePickerController()
//    }
//}
