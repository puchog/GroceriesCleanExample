//
//  GroceriesStaticStore.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/16/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class GroceriesStaticStore: GroceriesStoreProtocol {
  
  private let jsonString:String
  
  init() {
   jsonString = "[{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26},{\"name\":\"bananas\",\"baskets\":[5,20,10,10],\"unit_cost\":0.20},{\"name\":\"apples\",\"baskets\":[10,20,30],\"unit_cost\":0.26}]"
  }
  
  init(jsonString:String) {
    self.jsonString = jsonString
  }
  
  func fetchGroceryItems(_ completionHandler: (_ groceryItems: [GroceryItem], _ error: GroceryStoreError?) -> Void){
    var groceryItems:[GroceryItem] = []
    do {
      if let data = jsonString.data(using: .utf8),
        let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
        for item in json {
          var groceryItem = GroceryItem()
          if let name = item["name"] as? String {
            groceryItem.name = name
          }
          if let baskets = item["baskets"] as? [Int] {
            groceryItem.baskets = baskets
          }
          if let unitCost = item["unit_cost"] as? Double {
            groceryItem.unitCost = unitCost
          }
          
          groceryItems.append(groceryItem)
        }
      }
    } catch {
      print("Error deserializing JSON: \(error)")
      completionHandler([], GroceryStoreError.cannotFetch("Cannot fetch Grocery Items"))
    }
    
    completionHandler(groceryItems, nil)
    
  }
}
