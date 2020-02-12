//
//  RecipesViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 1/22/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit
import AVKit
import Firebase
class RecipesViewController: UIViewController {
    
    @IBOutlet weak var customRecipeTableView: UITableView!
    
    var vm = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCustomRecipes()
    }
    
    func setupCustomRecipes()
    {
        customRecipeTableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MealTableViewCell.identifier)

        vm.recipeDelegate = self
//        vm.pullSavedRecipes()
        
        let ref = Database.database().reference()
        
        ref.observe(.value, with: { [weak self] snapshot in
            self?.vm.savedRecipes = []
                    for child in snapshot.children
                    {
                        if let snapshot = child as? DataSnapshot
                        {

                            guard let item = snapshot.value as? [String:[String:Any]] else {return }
                                                
                            for (_,value) in item
                            {
                                
                                guard let name = value["name"] as? String,
                                let image = value["image"] as? String,
                                let id = value["id"] as? String,
                                    let ingredients = value["ingredients"] as? [String],
                                let instructions = value["instructions"] as? String
                                    else {return}
                                
                                let recipe = Recipe(name: name, id: id, instructions: instructions, image: image, ingredients: ingredients)
        //                        print(recipe)
                                self?.vm.savedRecipes.append(recipe)
                            }
                                
                            
                        }
                    }

                })
    }
    
    
}

extension RecipesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = customRecipeTableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        
        let recipe = vm.savedRecipes[indexPath.row]
        cell.recipe = recipe
        
        return cell
        
    }

}

extension RecipesViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let recipe = vm.savedRecipes[indexPath.row]
        vm.customRecipe = recipe

        let customDetailsVC = storyboard?.instantiateViewController(identifier: "CustomDetailsViewController") as! CustomDetailsViewController
        
        print(vm.customRecipe.name)
        customDetailsVC.vm = vm
        customDetailsVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(customDetailsVC, animated: true)
    }

}


extension RecipesViewController: RecipeDelegate
{
    func update() {
        DispatchQueue.main.async {
            self.customRecipeTableView.reloadData()

        }
    }
}
