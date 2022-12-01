//
//  ViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

class AddGroceryListViewController: UIViewController, AddShoppingChildViewControllerDelegate{
    

    //the menu state is stored
    enum MenuState{
        case opened;
        case closed;
    }
    
    //set menu state to closed
    private var menuState: MenuState = .closed;
    
    
    //add menu view controller to the view
    let menuVC = MenuViewController();
    
    //add the child view controller to the view
    let homeVC = AddGroceryListChildViewController();
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //add child vcs to the view
        addChildVCs()
    }
    
    private func addChildVCs(){
        //Set menu delegate
        menuVC.delegate = self;
        
        //add menu view controller to the view
        addChild(menuVC)
        
        //add menu view controller to the view
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //Set homeview controller delegate
        homeVC.delegate = self
        
        //add navigation view controller and put the grocery list as the root
        let navVC = UINavigationController(rootViewController: homeVC);
        addChild(navVC);
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


extension AddGroceryListViewController: AddGroceryListChildViewControllerDelegate{
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    
    //toggle menu button to state closed when opened or closed
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


extension AddGroceryListViewController: MenuViewControllerDelegate{
 
    
    //switch to respective page after item is hit on the menu
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
    
    //go to the grocery list page
    func addInfo()
    {
        //create view controller and then present
        let vc = GroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    //go to the add shopping list page
    func addShoppingList()
    {
        //create view controller and then present
        let vc = AddShoppingViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    // go to the add grocery item page
    func addGroceryItem()
    {
        //create view controller and then present
        let vc = AddGroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
}
