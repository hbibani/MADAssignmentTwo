//
//  ViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

class AddShoppingViewController: UIViewController, AddGroceryListChildViewControllerDelegate{
    
    //menu state of the menu to be stored
    enum MenuState{
        case opened;
        case closed;
    }
    
    
    //set menu state to closed initially
    private var menuState: MenuState = .closed;
    
    
    //add memu view controller to page
    let menuVC = MenuViewController();
    
    //add shoppihg child view controller to page
    let homeVC = AddShoppingChildViewController();
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //add child to page
        addChildVCs()
    }
    
    
    //add child vc to page
    private func addChildVCs(){
        //Menu
        menuVC.delegate = self;
        
        //add menu view controller to page
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //set delegate for home
        homeVC.delegate = self
        
        //add homeview controller as root to navigation view controller
        let navVC = UINavigationController(rootViewController: homeVC);
        //add navigation controller
        addChild(navVC);
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


extension AddShoppingViewController: AddShoppingChildViewControllerDelegate{
    
    //did tap menu button change
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    //when menu toggle button is pressed set to page
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


extension AddShoppingViewController: MenuViewControllerDelegate{
 
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
    
    //reset to home page
    func resetToHome()
    {
        //create view controller and then present
        let vc = ViewController();
        vc.modalPresentationStyle = .fullScreen;
        self.present(vc,animated: false, completion: nil)
    }
    
    
    //go to grocery list page
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
