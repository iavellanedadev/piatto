//
//  RecipeAddViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 2/5/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class RecipeAddViewController: UIViewController {

    @IBOutlet weak var dishNameTextField: UITextField!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var customRecipeImageVIew: UIImageView!
    let vm = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFields()
    }
    
    @IBAction func takePhotoButtonTouched(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func submitRecipeButtonTouch(_ sender: UIButton) {
        
        let ingredients = ingredientsTextView.text.components(separatedBy: "\n")
        guard let name = dishNameTextField.text,
            let instructions = directionsTextView.text        else {return }
        
        let random = Int.random(in: 0..<1000)
        
        if let currentPhoto = vm.currentPhoto?.path
        {
            vm.currentRecipe = Recipe(name: name,
                                         id: "\(random)",
                                       instructions: instructions,
                       image: currentPhoto,
                       ingredients: ingredients)
        }
        else
        {
            vm.currentRecipe = Recipe(name: name,
                                         id: "\(random)",
                                       instructions: instructions,
                                       image: "",
                       ingredients: ingredients)
        }
        vm.savedRecipes.append(vm.currentRecipe)

        dismiss(animated: true, completion: nil)
        
    }
    
    func setupFields()
    {
        ingredientsTextView.delegate = self
        directionsTextView.delegate = self
        
        ingredientsTextView.textColor = UIColor.lightGray
        directionsTextView.textColor = UIColor.lightGray
        
        ingredientsTextView.setBorder()
        directionsTextView.setBorder()
    }
    
}

extension RecipeAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        
            guard let data = pickedImage.jpegData(compressionQuality: 0.9) else {return}
            //save the image once we have picked it
            FileServiceManager.saveFile(data: data, isVideo: false)

            vm.currentPhoto = RecipeImg(path: "\(data.hashValue)", isVideo: false)
            customRecipeImageVIew.contentMode = .scaleToFill
            customRecipeImageVIew.image = pickedImage
            
          }
          picker.dismiss(animated: true, completion: nil)
    }
}

extension RecipeAddViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty
        {
            textView.text = "Ingredients:"
            textView.textColor = UIColor.lightGray
        }
    }
}

