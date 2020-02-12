//
//  Meal.swift
//  CapstoneApp
//
//  Created by Consultant on 1/23/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation


struct MealResults: Decodable
{
    let results: [Meal]
    

     private enum CodingKeys: String, CodingKey {
     case results = "meals"
    }
}

struct Meal: Decodable
{
    var mealName: String
    var image: String
    var id: String
    
    // Raw Value enum - each case will get a concrete value
   private enum CodingKeys: String, CodingKey
   {
       case mealName = "strMeal"
       case image = "strMealThumb"
       case id = "idMeal"
       
   }

   
}
