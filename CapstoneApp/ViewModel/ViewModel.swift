//
//  ViewModel.swift
//  CapstoneApp
//
//  Created by Consultant on 1/28/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

protocol MealDelegate: class
{
    func update()
}

protocol RecipeDelegate: class
{
    func update()
}

protocol CustomRecipeDelegate: class
{
    func updateCustom()
}

class ViewModel
{
    
    weak var mealDelegate: MealDelegate?
    weak var recipeDelegate: RecipeDelegate?
    weak var customRecipeDelegate: CustomRecipeDelegate?
    
    var meals = [Meal]()
       {
           didSet{
               mealDelegate?.update()
           }
       }
    
    var currentMeal: Meal!
    {
        didSet
        {
            getRecipe(currentMeal)
        }
    }
    
    var recipe: Recipe!
    {
        didSet
        {
            recipeDelegate?.update()
        }
    }
    
    var customRecipe: Recipe!
    {
        didSet
        {
            customRecipeDelegate?.updateCustom()
        }
    }
    
    var savedRecipes = [Recipe]()
    {
        didSet{
            recipeDelegate?.update()
        }
    }
    
    var currentPhoto: RecipeImg!
    
    var currentRecipe: Recipe!
    {
        didSet
        {
            saveCustomRecipe(recipe: currentRecipe)
        }
    }
    

    
}

extension ViewModel
{
    func getMeals(_ ingredient: String)
    {
        api.getMeals(with: ingredient) { [weak self] result in
            switch result
            {
            case .success(let meals):
                self?.meals = meals
                print("Meal Count: \(meals.count)")
                break
            case .failure (let error):
                print("Failed Meal Fetch Call: \(error.localizedDescription)")
                break
                
            }
        }
    }
    
    func getRecipe(_ meal: Meal)
    {
        api.getRecipe(meal: meal) { [weak self] result in
            switch result
            {
            case .success(let recipe):
                self?.recipe = recipe
                break
            case .failure(let error):
                print("Recipe Call Failed: \(error.localizedDescription) ")
                break
            }
        }
    }
    

    
    func saveCustomRecipe(recipe: Recipe)
    {
        fireb.postData(recipe: recipe)
    }
}
