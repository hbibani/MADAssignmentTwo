//
//  ViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

class GroceryListViewController: UIViewController, AddShoppingChildViewControllerDelegate {
    
    //menu state of the toggle bar
    enum MenuState{
        case opened;
        case closed;
    }
    
    
    //set menu state to closed
    private var menuState: MenuState = .closed;
    
    //menu view controller for the menu
    let menuVC = MenuViewController();
    
    //grocery list child will be added to page
    let homeVC = GroceryListChildViewController();
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    
    //add child vcs to page
    private func addChildVCs(){
        //Menu
        menuVC.delegate = self;
        
        //add child views
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //add child view controller to the navigation controller
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC);
        
        //add navigation controller
        addChild(navVC);
        
        //add the views
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


extension GroceryListViewController: GroceryListChildViewControllerDelegate{
    
    //did tap menu button
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    
    //toggle menu button to state open or closed
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


extension GroceryListViewController: MenuViewControllerDelegate{
 
    
    //when item is selected on the page go to respective page
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
    
    
    //go to grocery list item page
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
        //create view  controller and then present
        let vc = AddGroceryListViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
}
