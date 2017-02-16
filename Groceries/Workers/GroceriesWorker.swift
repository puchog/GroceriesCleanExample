//
//  GroceriesWorker.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/16/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class GroceriesWorker {
  
  
  var groceriesStore: GroceriesStoreProtocol
  
  init(groceriesStore: GroceriesStoreProtocol)
  {
    self.groceriesStore = groceriesStore
  }
  
  // MARK: - Business Logic
  
  
  func fetchGroceryItems(completion:([GroceryItem]) -> Void)
  {
    groceriesStore.fetchGroceryItems(){ groceryItems, error in
      completion(groceryItems)
    }   
  }

}


protocol GroceriesStoreProtocol
{
  // MARK: CRUD operations - Optional error
  
  func fetchGroceryItems(_ completionHandler: (_ groceryItems: [GroceryItem], _ error: GroceryStoreError?) -> Void)
  
}

// MARK: - Orders store CRUD operation errors

enum GroceryStoreError: Equatable, Error
{
  case cannotFetch(String)
}

func ==(lhs: GroceryStoreError, rhs: GroceryStoreError) -> Bool
{
  switch (lhs, rhs) {
  case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
  default: return false
  }
}

