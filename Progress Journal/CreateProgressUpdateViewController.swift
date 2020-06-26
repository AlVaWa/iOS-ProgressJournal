//
//  CreateProgressUpdateViewController.swift
//  Progress Journal
//
//  Created by Aleksander Waage on 24/06/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit

class CreateProgressUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // Temp value to initialise if sendt from exsisting progress update item
    var progressUpdateItem: ProgressUpdate? = nil
    
    // Tap functionality
    let tapRec = UITapGestureRecognizer()
    
    @IBOutlet weak var photoImageview: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.size.height / 2
        
        pickerController.delegate = self
        self.titleTextField.delegate = self
        
        // Initialising values if sendt from exsisting progress update item
        if let progressUpdateItem = progressUpdateItem {
            photoImageview.image = UIImage(data: progressUpdateItem.image!)
            titleTextField.text = progressUpdateItem.title
            addButton.isHidden = true
        }else{
            addButton.isHidden = false
        }
        
        // TapRecognizer for image
        tapRec.addTarget(self, action: #selector(self.tappedView))
        photoImageview.addGestureRecognizer(tapRec)
        photoImageview!.isUserInteractionEnabled = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Need to be @objc to be able reach it with: #selector(self.tappedView)
    @objc func tappedView(){
        if let progressUpdateItem = progressUpdateItem {
            performSegue(withIdentifier: "showLargePicture", sender: progressUpdateItem)
        }else {
            showPhotoLibrary()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            photoImageview.image = selectedImage
        }
        
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func showPhotoLibrary(){
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func exsistingPhotoTapped(_ sender: Any) {
        showPhotoLibrary()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let largeImageVC = segue.destination as? LargeImageViewController {
            let progressUpdateItem = sender as! ProgressUpdate
            largeImageVC.progressUpdateItem = progressUpdateItem
            
        }
    }
    
    
}
