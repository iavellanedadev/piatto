//
//  RecipeAPI.swift
//  CapstoneApp
//
//  Created by Consultant on 1/23/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation


enum LookupType:String{
    case ingredient = "filter.php?i="
    case meal = "search.php?s="
    case identifier = "lookup.php?i="
}

struct RecipeAPI
{
    let base: String = "https://www.themealdb.com/api/json/v1/1/"
    
    var param: String!
    
    var method: LookupType!
    
    init(_ param: String? = nil, _ method: LookupType)
       {
            self.param = param
            self.method = method
    
       }
       
       var recipeUrl: URL? {
           guard let lookupParam = param else {return nil}
        return URL(string: base + method.rawValue + lookupParam)
       }
    
    
}
