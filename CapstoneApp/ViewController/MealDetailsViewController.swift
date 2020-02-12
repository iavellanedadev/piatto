//
//  MealDetailsViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 1/28/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var mealMainImageView: UIImageView!
    
    @IBOutlet weak var mealMainInstructionsLabel: UILabel!
    
    @IBOutlet weak var mealMainIngredientsLabel: UILabel!
    
    @IBOutlet weak var mealScrollView: UIScrollView!
    
    var vm: ViewModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDetails()
    }
    
    func setupDetails()
    {
        
        mealScrollView.contentSize = CGSize(width: mealScrollView.contentSize.width, height: 2000)
        vm.recipeDelegate = self
    }
    
}

extension MealDetailsViewController: RecipeDelegate
{
    func update()
    {
        DispatchQueue.main.async {
            self.mealNameLabel.text = self.vm.recipe.name
            self.mealMainInstructionsLabel.text = self.vm.recipe.instructions
            
            guard let dishImageUrl = URL(string: self.vm.recipe.image) else {return }
                     
            dishImageUrl.getImage {[weak self] img in
                self?.mealMainImageView.image = img
            }
            
            
            var ingredients = ""
                
            if self.vm.recipe.ingredients != nil{

                self.vm.recipe.ingredients?.forEach({ (ing) in
                    ingredients.append(ing + "\n")
                })
                    self.mealMainIngredientsLabel.text
                    = ingredients
            }
                    
        }
 
    }
}


