//
//  MealTableViewCell.swift
//  CapstoneApp
//
//  Created by Consultant on 2/6/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealsImageView: UIImageView!
    
    static let identifier = "MealTableViewCell"
    
    var meal: Meal!
    {
        didSet{
            mealNameLabel.text = meal.mealName
            guard let dishImageUrl = URL(string: meal.image) else {return }
                 
                 dishImageUrl.getImage {[weak self] img in
                    self?.mealsImageView.image = img
                    }
        }
    
    }
    
    var recipe: Recipe!
    {
        didSet{
            mealNameLabel.text = recipe.name
            let content = recipe.image
            
            if content != ""{
                if let url = FileServiceManager.loadFile(from: content) {
                
                    mealsImageView.image = UIImage(contentsOfFile: url.path)
                }
            }
            else{
                mealsImageView.image = #imageLiteral(resourceName: "dubiousFood")
            }
        }
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        addShadow()
    }
}
