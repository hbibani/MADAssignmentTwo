//
//  ModShoppingListViewController.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 1/10/22.
//

import UIKit

class ModShoppingListViewController: UIViewController, AddGroceryListChildViewControllerDelegate{

    var shoppingListItem: ShoppingList!;

    //Stored for the menu state of the toggle
    enum MenuState{
        case opened;
        case closed;
    }
    
    
    //let menu state closed at the beginning
    private var menuState: MenuState = .closed;
    
    //add the menu view controller to the view
    let menuVC = MenuViewController();
    
    //The child vc in the child view controller
    let homeVC = ModShoppingListChildViewController();
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //add child VCs to the view
        addChildVCs()
    }
    
    
    //add the child VCs to the view
    private func addChildVCs(){
        //Menu
        
        //add menu view controller
        menuVC.delegate = self;
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //add home view controller
        homeVC.delegate = self
        
        //set shopping list items
        homeVC.shoppingListItem = self.shoppingListItem;
        
        //add navigation controller with root to child
        let navVC = UINavigationController(rootViewController: homeVC);
        addChild(navVC);
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


//toggle button through extension when the button is pressed
extension ModShoppingListViewController: ModShoppingListChildViewControllerDelegate{
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    //toggle menu and check open closed state and then change menu state
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


extension ModShoppingListViewController: MenuViewControllerDelegate{
 
    //The links for the menu in the navigation bar
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
    
    
    // Go to home page
    func resetToHome()
    {
        
        //create view controller and then present
        let vc = ViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    
    //Go to Grocery list page
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
    
    
    //Go to add grocery item page
    func addGroceryItem()
    {
        //create view controller and then present
        let vc = AddGroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }

}
