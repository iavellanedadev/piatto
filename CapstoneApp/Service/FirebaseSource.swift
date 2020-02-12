//
//  FirebaseSource.swift
//  CapstoneApp
//
//  Created by Consultant on 2/5/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation
import Firebase

let fireb = FirebaseSource.shared

final class FirebaseSource {
    
    
    static let shared = FirebaseSource()
    let vm = ViewModel()
    private init() {}
    let ref = Database.database().reference()
    let childRef = Database.database().reference(withPath: "recipes")

    
    func postData(recipe: Recipe)
    {
        let recipeItemRef = self.childRef.child("\(recipe.name.lowercased().replacingOccurrences(of: " ", with: ""))-\(recipe.id)")
        
        recipeItemRef.setValue(recipe.nsDictionary)
        
        print("Recipe Saved")
    }
}
