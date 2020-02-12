//
//  CustomDetailsViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 2/6/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class CustomDetailsViewController: UIViewController {

 
    @IBOutlet weak var customScrollView: UIScrollView!
    
    @IBOutlet weak var customImageView: UIImageView!
    var vm: ViewModel!
    @IBOutlet weak var customMainLabel: UILabel!
    
    @IBOutlet weak var customInstructionsLabel: UILabel!
    @IBOutlet weak var customIngredientsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
                customScrollView.contentSize = CGSize(width: customScrollView.contentSize.width, height: 2000)
        // Do any additional setup after loading the view.
        
        customMainLabel.text = vm.customRecipe.name
        customInstructionsLabel.text = vm.customRecipe.instructions
        let content = vm.customRecipe.image
        if content != ""{
             if let url = FileServiceManager.loadFile(from: content) {
             
                 customImageView.image = UIImage(contentsOfFile: url.path)
             }
         }
         else{
             customImageView.image = #imageLiteral(resourceName: "dubiousFood")
         }
        
                    var ingredients = ""
            
        if vm.customRecipe.ingredients != nil{

            vm.customRecipe.ingredients?.forEach({ (ing) in
                ingredients.append(ing + "\n")
            })
                customIngredientsLabel.text
                = ingredients
        }
    }


}


