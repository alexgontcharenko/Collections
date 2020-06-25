//
//  ImageViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import AVFoundation

class ImageViewController: UIViewController {
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var user = UserProfile()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNextButton()
        prepareBackButton()
        prepareImage()
    }
    
    func prepareView() {
        avatarLabel.text = kAvatarLabel
        avatarButton.setTitle("", for: .normal)
        avatarButton.addTarget(self, action: #selector(onOpenImagePicker), for: .touchUpInside)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func prepareNextButton() {
        nextButton.setTitle(kNextButtonTitle, for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 0.5 * nextButton.frame.size.width
        nextButton.clipsToBounds = true
        nextButton.backgroundColor = UIColor.lightText
        
        nextButton.addTarget(self, action: #selector(onTapNextButton), for: .touchUpInside)
    }
    
    func prepareBackButton() {
        backButton.setTitle(kBackButtonTitle, for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.layer.cornerRadius = 0.5 * backButton.frame.size.width
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor.lightText
        
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
    }
    
    func prepareImage() {
        avatarImage.backgroundColor = UIColor.lightText
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 0.5 * avatarImage.frame.size.width
    }
    
    @objc func onOpenImagePicker() {
        onPhotoAction()
    }
    
    func onPhotoAction() {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    self.onOpenMedia(source: .camera)
                } else {

                }
            }
            print("First Action pressed")
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Choose from gallery", style: .default) { action -> Void in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    self.onOpenMedia(source: .photoLibrary)
                } else {

                }
            }
            print("Second Action pressed")
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func onOpenMedia(source: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.mediaTypes = ["public.image", "public.movie"]
            pickerController.sourceType = source
            
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func prepareAvatar() {
        if let image = user.image {
            avatarImage.image = image
        }
    }
    
    @objc func onTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapNextButton() {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController{
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ImageViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        var imageToSave = selectedImage
        let imageWidth = CGFloat(600.0)
        if selectedImage.size.height > imageWidth ||
            selectedImage.size.width > imageWidth {
            user.image = selectedImage            // upload an image to the storage, get the URL,  set to the user URL string
            StorageManager.shared.upload(userPhoto: selectedImage, userId: user.email) { (result) in
                switch result {
                case .success(let url):
                    self.user.imageURL = url.absoluteString
                    self.prepareAvatar()
                case .failure(let error):
                    self.showAlert(title: kAlertTitleWrong, message: error.localizedDescription)
                }
            }
            
            //imageToSave = UIImage.resizeImage(sourceImage: selectedImage, scaledToWidth: imageWidth)
        }
        
        //updateUserIconOnServer(avatar: imageToSave)
        //uploadAvatarToServer(avatar: imageToSave)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        self.prepareAvatar()
    }
    
}

extension ImageViewController: UINavigationControllerDelegate {
    
}



