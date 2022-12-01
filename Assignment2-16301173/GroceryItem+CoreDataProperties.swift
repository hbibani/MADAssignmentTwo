//
//  GroceryItem+CoreDataProperties.swift
//  Assignment2-16301173
//
//  Created by Heja Bibani on 4/10/22.
//
//

import Foundation
import CoreData

//grocery item
extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "GroceryItem")
    }

    //attributes
    @NSManaged public var image: Data
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var shoppinglistitem: NSSet

}

// MARK: Generated accessors for shoppinglistitem
extension GroceryItem {

    @objc(addShoppinglistitemObject:)
    @NSManaged public func addToShoppinglistitem(_ value: ShoppingListItem)

    @objc(removeShoppinglistitemObject:)
    @NSManaged public func removeFromShoppinglistitem(_ value: ShoppingListItem)

    @objc(addShoppinglistitem:)
    @NSManaged public func addToShoppinglistitem(_ values: NSSet)

    @objc(removeShoppinglistitem:)
    @NSManaged public func removeFromShoppinglistitem(_ values: NSSet)

}

extension GroceryItem : Identifiable {

}
