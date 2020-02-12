//
//  IngredientRecipeService.swift
//  CapstoneApp
//
//  Created by Consultant on 1/23/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

enum MealsError: Error{
    case badUrl(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias MealsHandler = (Result<[Meal], MealsError>) -> Void

typealias RecipeHandler = (Result<Recipe, MealsError>) -> Void

let api = IngredientRecipeService.shared

final class IngredientRecipeService
{
    static let shared = IngredientRecipeService()
    
    
    private init() {}
    
    func getMeals(with parameter: String, completion: @escaping MealsHandler)
    {
        
        var meals =  [Meal]()
        
         DispatchQueue.global(qos: .userInteractive).async{
        
        guard let url = RecipeAPI(parameter, LookupType.ingredient).recipeUrl else {
                  completion(.failure(.badUrl("Couldn't Create Meal URL")))
                  return }
        
    
       
            URLSession.shared.dataTask(with: url) { (dat, _, err) in
                         if let error = err{
                             completion(.failure(.badDataTask(error.localizedDescription)))
                             return
                         }
                   if let data = dat{
                             do{

                                   let response = try JSONDecoder().decode(MealResults.self, from: data)
                                   meals = response.results
                                 }catch{
                                 completion(.failure(.badDataTask(error.localizedDescription)))
                                 return
                             }
                     }
                     
                     
                 }.resume()
        }
     
        DispatchQueue.global().async{

        guard let url2 = RecipeAPI(parameter, LookupType.meal).recipeUrl else {
            print("Error on Second URL Form")

                  completion(.success(meals))
                  return }
        
              URLSession.shared.dataTask(with: url2) { (dat, _, err) in
                      if let error = err{
                        print("Error on Second Call: \(error.localizedDescription)")
                          completion(.success(meals))
                          return
                      }
                if let data = dat{
                          do{

                            let response = try JSONDecoder().decode(MealResults.self, from: data)
                                
                            meals.append(contentsOf: response.results)
                            
                                completion(.success(meals))
                          }catch{
                            print("Error on Second Call: \(error.localizedDescription)")

                              completion(.success(meals))
                              return
                          }
                      
                  }
                  
                  
              }.resume()
        }
    }

    func getRecipe(meal: Meal, completion: @escaping RecipeHandler)
    {
        guard let url = RecipeAPI(meal.id, LookupType.identifier).recipeUrl else {
                  completion(.failure(.badUrl("Couldn't Create Meal URL")))
                  return }
        
              URLSession.shared.dataTask(with: url) { (dat, _, err) in
                      if let error = err{
                          completion(.failure(.badDataTask(error.localizedDescription)))
                          return
                      }
                
                if let data = dat{
                          do{
                        let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>
                            
                            guard let mealResp = jsonResp["meals"] as? NSArray else {return }
                            
                            let meals = mealResp[0] as! [String: Any]

                            guard let mealName = meals["strMeal"] as? String,
                                let mealId = meals["idMeal"] as? String,
                                let mealInstructions = meals["strInstructions"] as? String,
                                let mealImage = meals["strMealThumb"] as? String
                                else {return}
                            
                            //create arrays to hold our ingredients/measures (as Strings)
                            var ingredientsArray = [String]()
                            var measureArray = [String]()
                            //because of the structure of the json, we must first insure that the key has an ingredient value
                            for (key,value) in meals{
                                if key.contains("strIngredient")
                                {
                                    guard let ingredient = value as? String else {return}
                                    ingredientsArray.append(ingredient)
                                }
                                else if key.contains("strMeasure")
                                {
                                    guard let measure = value as? String else {return}
                                    
                                    measureArray.append(measure)
                                }
                            }
                            var completeIngredients = [String]()
                            //we have two separate arrays with values that correlate to one another
                            for i in 0..<ingredientsArray.count
                            {
                                let amt = measureArray[i]
                                let ing = ingredientsArray[i]
                                
                                completeIngredients.append(amt + ing)
                            }
                            
                            
                            let recipe = Recipe(name: mealName, id: mealId, instructions: mealInstructions, image: mealImage, ingredients: completeIngredients)
                            
                            completion(.success(recipe))
                            
                              }catch{
                              completion(.failure(.badDataTask(error.localizedDescription)))
                              return
                          }
                      
                  }
                  
                  
              }.resume()
    }
}
