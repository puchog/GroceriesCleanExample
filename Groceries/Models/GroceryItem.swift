//
//  GroceryItem.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/16/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

struct GroceryItem:Equatable {
  var name:String?
  var baskets:[Int]?
  var unitCost:Double?
  
  static func ==(lhs: GroceryItem, rhs: GroceryItem) -> Bool
  {
    return lhs.name == rhs.name
  }
}
