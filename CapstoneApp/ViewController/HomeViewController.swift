//
//  ViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 1/20/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var recipesTableView: UITableView!
    let vm = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupHome()
        searchSetup()
    }
    
    private func setupHome()
       {
            recipesTableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MealTableViewCell.identifier)

            recipesTableView.tableFooterView = UIView(frame: .zero)
           
            recipesTableView.separatorStyle = .none
           
            recipesTableView.backgroundColor = UIColor.gray
            vm.mealDelegate = self
            vm.getMeals("cilantro")
        }
       
       private func searchSetup()
       {
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.delegate = self
           navigationItem.hidesSearchBarWhenScrolling = false
           navigationItem.searchController = searchController
       }

}

extension HomeViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipesTableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        
        let meal = vm.meals[indexPath.row]
        
        cell.meal = meal
        
        return cell
        
    }

}

extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          
          let mealDetailsVC = storyboard?.instantiateViewController(identifier: "MealDetailsViewController") as! MealDetailsViewController
          
          vm.currentMeal = vm.meals[indexPath.row]
          
          mealDetailsVC.vm = vm

          mealDetailsVC.hidesBottomBarWhenPushed = true
          navigationController?.view.backgroundColor = .white
          navigationController?.pushViewController(mealDetailsVC, animated: true)
    
      }
}

extension HomeViewController: MealDelegate
{
    func update()
    {
        DispatchQueue.main.async {
            self.recipesTableView.reloadData();
        }
    }
}


extension HomeViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
        let sanitized = search.replacingOccurrences(of: " ", with: "_").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        vm.getMeals(sanitized)
    }
}
