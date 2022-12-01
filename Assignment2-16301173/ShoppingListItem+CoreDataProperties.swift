//
//  ShoppingListItem+CoreDataProperties.swift
//  Assignment2-16301173
//
//  Created by Heja Bibani on 4/10/22.
//
//

import Foundation
import CoreData


//shopping list item
extension ShoppingListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingListItem> {
        return NSFetchRequest<ShoppingListItem>(entityName: "ShoppingListItem")
    }

    
    //NS managed attributes
    @NSManaged public var checked: Bool
    @NSManaged public var quantity: String
    @NSManaged public var groceryitem: GroceryItem
    @NSManaged public var shoppinglist: ShoppingList

}

extension ShoppingListItem : Identifiable {

}
