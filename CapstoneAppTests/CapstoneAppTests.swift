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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMeal() {
        measure {
            api.getMeals(with: "chicken") { mealResult in
                switch mealResult
                {
                case .success(let meals):
                    XCTAssert(meals.count > 0, "No Meals Found")
                case .failure(let error):
                    print("Error Fetching Meals in Test: \(error.localizedDescription)")
                }
            }
        }

    }



}
