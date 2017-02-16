//
//  CountProductsModels.swift
//  Groceries
//
//  Created by Juan Giannuzzo on 2/15/17.
//  Copyright (c) 2017 me. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct CountProducts
{
  struct Something
  {
    struct Request
    {
      
    }
    
    struct Response
    {
      var items:[GroceryItem]
    }
    
    struct ViewModel
    {
      var displayedGroceries:[String]
    }
  }
}