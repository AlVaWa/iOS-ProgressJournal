//
//  CreateProgressUpdateViewController.swift
//  Progress Journal
//
//  Created by Aleksander Waage on 24/06/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit

class CreateProgressUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Temp values to initialise if sendt from exsisting progress update item
    var progressUpdateTitle: String? = nil
    var progressUpdateImage: UIImage? = nil
    
    @IBOutlet weak var photoImageview: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = addButton.frame.size.height / 2
        pickerController.delegate = self
        
        // Initialising values if sendt from exsisting progress update item
        if(progressUpdateTitle != nil && progressUpdateImage != nil){
            photoImageview.image = progressUpdateImage
            titleTextField.text = progressUpdateTitle
            addButton.isHidden = true
        }else{
            addButton.isHidden = false
        }
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            photoImageview.image = selectedImage
        }
        
        pickerController.dismiss(animated: true, completion: nil)
    }
    @IBAction func exsistingPhotoTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let progressUpdateToBeSaved = ProgressUpdate(context: context)
            progressUpdateToBeSaved.title = titleTextField.text
            progressUpdateToBeSaved.image = photoImageview.image?.jpegData(compressionQuality: 1.0)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
