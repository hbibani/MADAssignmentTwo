//
//  ShoppingList+CoreDataProperties.swift
//  Assignment2-16301173
//
//  Created by Heja Bibani on 4/10/22.
//
//

import Foundation
import CoreData


//shopping list items
extension ShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    
    //attributes
    @NSManaged public var date: String
    @NSManaged public var id: String
    @NSManaged public var location: String
    @NSManaged public var shopname: String
    @NSManaged public var shoppinglistitem: NSSet

}

// MARK: Generated accessors for shoppinglistitem
extension ShoppingList {

    
    //relationship items
    @objc(addShoppinglistitemObject:)
    @NSManaged public func addToShoppinglistitem(_ value: ShoppingListItem)

    @objc(removeShoppinglistitemObject:)
    @NSManaged public func removeFromShoppinglistitem(_ value: ShoppingListItem)

    @objc(addShoppinglistitem:)
    @NSManaged public func addToShoppinglistitem(_ values: NSSet)

    @objc(removeShoppinglistitem:)
    @NSManaged public func removeFromShoppinglistitem(_ values: NSSet)

}

extension ShoppingList : Identifiable {

}
