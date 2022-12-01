//
//  ViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    //store menu state of menu
    enum MenuState{
        case opened;
        case closed;
    }
    
    
    //initial menu state is closed
    private var menuState: MenuState = .closed;
    
    
    //Add Menu View controller
    let menuVC = MenuViewController();
    
    //child view controller
    let homeVC = HomeViewController();
    
    //Navigation controller to add
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //add child to the view
        addChildVCs()
    }
    
    private func addChildVCs(){
        //Menu
        menuVC.delegate = self;
        
        //add menu to the view
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //Home
        
        //add child to the view controller in a navigation view controller
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC);
        addChild(navVC);
        view.addSubview(navVC.view);
        navVC.didMove(toParent: self);
        self.navVC = navVC;
    }

}


extension ViewController: HomeViewControllerDelegate{
    func didTapMenuButton(){

        toggleMenu(completion: nil);
    }
    
    //toggle menu state to open and closed when pressed
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


extension ViewController: MenuViewControllerDelegate{
 
    //move to desired page when pressed a menu item
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
    
    
    
    // go to the home page
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
