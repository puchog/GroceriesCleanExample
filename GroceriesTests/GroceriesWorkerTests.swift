//
//  GroceriesWorkerTests.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/16/17.
//  Copyright © 2017 me. All rights reserved.
//

import XCTest

class GroceriesWorkerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupOrdersWorker()
  {
 
  }
  
  // MARK: Test doubles
  
  class GroceriesStaticStoreSpy: GroceriesStaticStore
  {
    // MARK: Method call expectations
    var fetchGroceryItemsCalled = false
    
    // MARK: Spied methods
    override   func fetchGroceryItems(_ completionHandler: (_ groceryItems: [GroceryItem], _ error: GroceryStoreError?) -> Void){
      fetchGroceryItemsCalled = true
      super.fetchGroceryItems(completionHandler)
    }
  }
  
  // MARK: Test
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testEmptyJson(){
    let jsonString = ""
    let store = GroceriesStaticStoreSpy(jsonString:jsonString)
    let worker = GroceriesWorker(groceriesStore: store)
    
    worker.fetchGroceryItems { (items) in
      XCTAssert(items.count == 0, "Invalid number of groceries parsed")
    }
    XCTAssert(store.fetchGroceryItemsCalled, "Calling fetchGroceryItems() should ask the data store for a list of orders")
  }
  
  
  func testBaseJson(){
    let jsonString = "[{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20}]"
    let store = GroceriesStaticStoreSpy(jsonString:jsonString)
    let worker = GroceriesWorker(groceriesStore: store)
    
    worker.fetchGroceryItems { (items) in
      XCTAssert(items.count == 2, "Invalid number of groceries parsed")
    }
    XCTAssert(store.fetchGroceryItemsCalled, "Calling fetchGroceryItems() should ask the data store for a list of orders")
    
  }
  
  func testDuplicatedItemsJson(){
    let jsonString = "[{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20},{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20},{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20},{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20},{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20}]"
    let store = GroceriesStaticStoreSpy(jsonString:jsonString)
    let worker = GroceriesWorker(groceriesStore: store)
    
    worker.fetchGroceryItems { (items) in
      XCTAssert(items.count == 10, "Invalid number of groceries parsed")
    }
    XCTAssert(store.fetchGroceryItemsCalled, "Calling fetchGroceryItems() should ask the data store for a list of orders")
  }
  
  func testInvalidJson(){
    let jsonString = "INVALID JSON"
    let store = GroceriesStaticStoreSpy(jsonString:jsonString)
    let worker = GroceriesWorker(groceriesStore: store)
    
    worker.fetchGroceryItems { (items) in
      XCTAssert(items.count == 0, "Invalid number of groceries parsed")
    }
    XCTAssert(store.fetchGroceryItemsCalled, "Calling fetchGroceryItems() should ask the data store for a list of orders")
  }
  
}
