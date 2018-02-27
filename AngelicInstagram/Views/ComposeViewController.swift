//
//  ComposeViewController.swift
//  AngelicInstagram
//
//  Created by angel gonzalez on 2/25/18.
//  Copyright © 2018 angel gonzalez. All rights reserved.
//

import UIKit
import Toucan
class ComposeViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickImageView(_ sender: Any) {
        // Instantiate a UIImagePickerController
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Resize images for parse
        let resizedImage = Toucan.Resize.resizeImage(originalImage, size: CGSize(width: 200, height: 200))
        postView.image = resizedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButton(_ sender: Any) {
        captionField.resignFirstResponder()
        print("Clicked share")
        Post.postUserImage(image: postView.image, withCaption: captionField.text) { (success, error) in
            if success {
                print("share sucessful")
            }
            else if let e = error as NSError? {
                print(e.localizedDescription)
                print("share unsuccesfull")
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        captionField.resignFirstResponder()
        print("cancel worked")
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }

}
