//
//  ListShoppingItemsViewController.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 1/10/22.
//

import UIKit

class ListShoppingItemsViewController: UIViewController, AddGroceryListChildViewControllerDelegate {
    
    //Menu state options storage
    enum MenuState{
        case opened;
        case closed;
    }
    
    //set to closed on impact
    private var menuState: MenuState = .closed;
    
    //add menu  view controller to page
    let menuVC = MenuViewController();
    
    //list shopping item child controller
    let homeVC = ListShoppingItemsChildViewController();
    var navVC: UINavigationController?
    
    //pass shopping list to child when invoked
    var shoppingList: ShoppingList?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //add child vcs to the view
        addChildVCs()
    }
    
    //add child vcs
    private func addChildVCs(){
        //Menu
        menuVC.delegate = self;
        
        //add menu view controller
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //Home
        homeVC.delegate = self
        //add navigation view controller
        let navVC = UINavigationController(rootViewController: homeVC);
        addChild(navVC);
        view.addSubview(navVC.view);
        homeVC.shoppingList = self.shoppingList;
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}

//toggle menu when button is pressed
extension ListShoppingItemsViewController: ListShoppingItemsChildViewControllerDelegate{
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    //switch states of toggle when pressed
    func toggleMenu(completion: (() -> Void)?){
        switch menuState
        {
            case .closed:
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100;
                } completion: {[weak self]
                    done in if done{
                        self?.menuState = .opened;

                    }
                }

            
            case .opened:
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = 0;
                } completion: {[weak self]
                    done in if done{
                        self?.menuState = .closed;
                        DispatchQueue.main.async{
                            completion?();
                        }
                        
                    }
                }

        }
    }
}


extension ListShoppingItemsViewController: MenuViewControllerDelegate{
 
    //when menu item is selected go to respective page
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions) {
        toggleMenu{ [weak self] in
            switch menuItem {
            
            case .home:
                self?.resetToHome();
            case .info:
                self?.addInfo();
            case .appRating:
                self?.addShoppingList();
                break
            case .shareApp:
                self?.addGroceryItem();
                break
            }
            
        }
    }
    
    
    //go to home page
    func resetToHome()
    {
        //create view controller and then present
        let vc = ViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    
    //go to grocery list view page
    func addInfo()
    {
        
        //create view controller and then present
        let vc = GroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    
    //go to add shopping list page
    func addShoppingList()
    {
        //create view controller and then present
        let vc = AddShoppingViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    
    //go to add grocery item page
    func addGroceryItem()
    {
        //create view controller and then present
        let vc = AddGroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
}
