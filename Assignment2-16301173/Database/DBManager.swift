//
//  DBManager.swift
//  X11dbtest
//
//  Created by Heja Bibani on 15/1/21.
//  Copyright © 2021 Heja Bibani All rights reserved.
//

import UIKit
import CoreData
class DBManager: NSObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Add Grocery Item to the Database
    func addGroceryItem(name: String, id: String, pngImg: Data?)
    {
        do{
            
            //create object and then delete
            let newObject = GroceryItem(context: self.context)
            newObject.name = name;
            newObject.id = id;
            if pngImg != nil{
                newObject.image = pngImg!;
            }

            try self.context.save()
        }
        catch{
            //
        }
    }
    
    //Delete Grocery Item
    func deleteGroceryItem(objectToRemove: GroceryItem)
    {
        //delete item using context
        self.context.delete(objectToRemove);
        do{
            try self.context.save();
        }
        catch{
            
        }
    }
    
    //Retrieve all grocery items
    func retrieveGroceryList() -> [GroceryItem]
    {
        
        //items to be sent back
        var items:[GroceryItem]?

        do{
            //retrieve items
            items = try context.fetch(GroceryItem.fetchRequest());
        }
        catch{
            //
        }
        
        return items!;
    }
    
    
    //modify grocery item in database
    func modifyGroceryItem(item: GroceryItem, name: String, id: String, image: Data)
    {
        
        //change items
        item.name = name;
        item.id = id;
        item.image = image;
        
        
        //save in try catch
        do{
            try self.context.save()
        }
        catch{
            //
        }
    }
    
    //-------------------------------------------------------------------------
    
    //Add Shopping List Item to the Database
    func addShoppingListItem(name: String, id: String, location: String, date: String)
    {
        do{
            
            //create new object and the save context
            let newObject = ShoppingList(context: self.context)
            newObject.shopname = name;
            newObject.id = id;
            newObject.location = location;
            newObject.date = date;
            try self.context.save()
        }
        catch{
            //
        }
    }
    
    //Delete Shopping List Item
    func deleteShoppingListItem(objectToRemove: ShoppingList)
    {
        
        //delete object in context save
        self.context.delete(objectToRemove);
        do{
            try self.context.save();
        }
        catch{
            
        }
    }
    
    //Retrieve all grocery items
    func retrieveShoppingList() -> [ShoppingList]
    {
        //store items to return
        var items:[ShoppingList]?

        //retrieve items from shopping list
        do{
            items = try context.fetch(ShoppingList.fetchRequest());
        }
        catch{
            //
        }
        
        return items!;
    }
    
    
    //modify shopping list item
    func modifyShoppingListItem(item: ShoppingList, name: String, id: String, location: String, date: String)
    {
        item.shopname = name;
        item.id = id;
        item.location = location;
        item.date = date;
        
        
        //save in try catch
        do{
            try self.context.save()
        }
        catch{
            //
        }
    }
    
    
    
    //-----------Shoppinglist items
    
    //Retrieve all grocery items
    func retrieveShoppingListItems() -> [ShoppingListItem]
    {
        var items:[ShoppingListItem]?

        do{
            items = try context.fetch(ShoppingListItem.fetchRequest());
        }
        catch{
            //
        }
        
        return items!;
    }
    
    //Add Shopping Item to List
    func addShoppingListItemToList(shoppinglist: ShoppingList, groceryitem: GroceryItem, quantity: String)
    {
        do{
            let newObject = ShoppingListItem(context: self.context)
            newObject.checked = false;
            newObject.groceryitem = groceryitem;
            newObject.quantity = quantity;
            newObject.shoppinglist = shoppinglist;
            try self.context.save()
        }
        catch{
            //
        }
    }
    
    
    //delete the shopping list item
    func deleteShoppingListItem(objectToRemove: ShoppingListItem)
    {
        
        //delete using context and save
        self.context.delete(objectToRemove);
        do{
            try self.context.save();
        }
        catch{
            
        }
    }

}
