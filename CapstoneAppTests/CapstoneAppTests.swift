//
//  CapstoneAppTests.swift
//  CapstoneAppTests
//
//  Created by Consultant on 2/15/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import XCTest
@testable import CapstoneApp

class CapstoneAppTests: XCTestCase {

    var mockService : MockIngredientsRecipeService!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = MockIngredientsRecipeService()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMeal() {

        if let meals = mockService.getMockMealData(){
            XCTAssertEqual(meals.count, 24)
        }
    }
}

class MockIngredientsRecipeService: MealFetchServiceable
{
    var mockDataFileName = ""

    func getMeals(with parameter:String = "chicken", completion: @escaping MealsHandler) {
        if let meals = self.getMockMealData()
        {
            completion(.success(meals))
        }
    }

    func getMockMealData() -> [Meal]?
    {
        mockDataFileName = "mockMeals"
        var meals =  [Meal]()

        let bundle = Bundle(for: MockIngredientsRecipeService.self)
        
        if let url = bundle.url(forResource: mockDataFileName, withExtension: "json")
        {
            do{
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(MealResults.self, from: data)
                
                meals = jsonData.results
                return meals
            }catch{
                print("Error: \(error.localizedDescription)")
                return nil
            }
        }
        
        return nil
    }
    

    
    
}
