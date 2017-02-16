//
//  CountProductsPresenterTests.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/16/17.
//  Copyright © 2017 me. All rights reserved.
//

import XCTest

class CountProductsPresenterTests: XCTestCase {
  
  var sut: CountProductsPresenter!
  
  override func setUp() {
    super.setUp()
    setupCountProductsPresenter()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupCountProductsPresenter()
  {
    sut = CountProductsPresenter()
  }
  
  // MARK: Test doubles
  
  class CountProductsPresenterSpy: CountProductsPresenterOutput
  {
    // MARK: Method call expectations
    var displayFetchedGroceryItemsCalled = false
    
    // MARK: Argument expectations
    var viewModel: CountProducts.Something.ViewModel!
    
    // MARK: Spied methods
    func displayFetchedGroceryItems(viewModel: CountProducts.Something.ViewModel)
    {
      displayFetchedGroceryItemsCalled = true
      self.viewModel = viewModel
    }
  }
  
  // MARK: Tests
  func testBaseGroceryList() {
    // Given
    let countProductsPresenterSpy = CountProductsPresenterSpy()
    sut.output = countProductsPresenterSpy
    
    let items = [GroceryItem(name:"apples", baskets:[10,20,30],unitCost:1.0),
                 GroceryItem(name:"bananas", baskets:[5,20,10,10],unitCost:1.0)]
    let response = CountProducts.Something.Response(items: items)
    
    // When
    sut.presentFetchedGroceryItems(response: response)
    
    // Then
    XCTAssert(countProductsPresenterSpy.displayFetchedGroceryItemsCalled, "Presenting fetched Groceries should ask view controller to display them")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries.count,2, "Wrong number of list items")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries[0], "A total of 60 apples where sold in 3 baskets", "Wrong Output")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries[1], "A total of 45 bananas where sold in 4 baskets", "Wrong Output")
    
  }
  
  // MARK: Tests
  func testDuplicatedItemGroceryList() {
    // Given
    let countProductsPresenterSpy = CountProductsPresenterSpy()
    sut.output = countProductsPresenterSpy
    
    let items = [GroceryItem(name:"apples", baskets:[10,20,30],unitCost:1.0),
                 GroceryItem(name:"bananas", baskets:[5,20,10,10],unitCost:1.0),
                 GroceryItem(name:"apples", baskets:[10,20,30],unitCost:1.0)]
    let response = CountProducts.Something.Response(items: items)
    
    // When
    sut.presentFetchedGroceryItems(response: response)
    
    // Then
    XCTAssert(countProductsPresenterSpy.displayFetchedGroceryItemsCalled, "Presenting fetched Groceries should ask view controller to display them")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries.count,2, "Wrong number of list items")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries[0], "A total of 120 apples where sold in 6 baskets", "Wrong Output")
    XCTAssertEqual(countProductsPresenterSpy.viewModel.displayedGroceries[1], "A total of 45 bananas where sold in 4 baskets", "Wrong Output")
    
  }
}
