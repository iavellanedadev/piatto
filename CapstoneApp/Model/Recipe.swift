//
//  Recipe.swift
//  CapstoneApp
//
//  Created by Consultant on 1/23/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

struct Recipe
{
    let name: String
    let id: String
    let instructions: String
    let image: String
//    let video: String
    let ingredients : [String]?
    
    var dictionary: [String: Any] {
        return ["name": name,
                "image": image,
                "id": id,
                "instructions": instructions,
                "ingredients": ingredients ?? []]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}

struct RecipeImg
{
    let path: String?
    let isVideo: Bool
}
