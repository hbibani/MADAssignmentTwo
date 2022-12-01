//
//  ViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

class ModGroceryItemViewController: UIViewController{
    

    //menu state of the toggled nav bar
    enum MenuState{
        case opened;
        case closed;
    }
    
    
    //Grocery Item to push to child
    var groceryitem: GroceryItem!;

    
    //set menu state as closed in the beginning
    private var menuState: MenuState = .closed;
    
    
    //menu view controller
    let menuVC = MenuViewController();
    
    //Add child modify grocery item to the page later on
    let homeVC = ModGroceryItemChildViewController();
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //Add child VCs to the page
        addChildVCs()
    }
    
    private func addChildVCs(){
        //Menu
        //set the menu delegate
        menuVC.delegate = self;
        //add menu vc to the page
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //Home
        //set thet home page
        homeVC.delegate = self
        homeVC.groceryitem = self.groceryitem;
        //add navigation controller
        let navVC = UINavigationController(rootViewController: homeVC);
        addChild(navVC);
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


extension ModGroceryItemViewController: ModGroceryItemChildViewControllerDelegate{
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    //toggle menu state when button is pressed
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


extension ModGroceryItemViewController: MenuViewControllerDelegate{
 
    //when menu item is clicked go to the needed page
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
    
    
    //go to the home page
    func resetToHome()
    {
        //create view controller and then present
        let vc = ViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    //Go to Grocery Item page
    func addInfo()
    {
        
        //crete view controller and then present
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
