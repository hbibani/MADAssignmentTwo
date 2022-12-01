//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}




class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UITableViewDelegate{

    
    //all the shopping lists in one
    public var items:[ShoppingList]?
    
    //past shopping lists
    public var past:[ShoppingList]?
    
    //present shopping lists
    public var present:[ShoppingList]?
    
    //set parameters for present shopping lists
    private let labelpresent: UILabel = {
        let label = UILabel();
        label.text = "Present";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    //set parameters for the past shopping lists
    private let labelpast: UILabel = {
        let label = UILabel();
        label.font = .systemFont(ofSize: 17, weight: .bold);
        label.text = "Past";
        return label
    }()
    
    //set parameters for the delete button
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Delete", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //set parameters for the second delete button
    let btnLogin2:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Delete", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton2), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //table view for present shopping lists
    private let tableView: UITableView = {
        let tableView = UITableView();
        tableView.register(CustomTableViewCell2.self, forCellReuseIdentifier: CustomTableViewCell2.identifier)
        tableView.isUserInteractionEnabled = true;
        tableView.allowsSelection = false;
        return tableView;
    }()
    
    
    //table view for past shopping lists
    private let tableView2: UITableView = {
        let tableView = UITableView();
        tableView.register(CustomTableViewCell2.self, forCellReuseIdentifier: CustomTableViewCell2.identifier)
        tableView.isUserInteractionEnabled = true;
        tableView.allowsSelection = false;
        return tableView;
    }()
    
    weak var delegate: HomeViewControllerDelegate?;
    
    //added two table view delegates because we have two on the same page
    var FirstTableView: FirstTableViewDataSource = FirstTableViewDataSource();
    var SecondTableView: SecondTableViewDataSource = SecondTableViewDataSource();

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Shopping List";
        
        //set delegates for the table view
        tableView.dataSource = FirstTableView;
        tableView2.dataSource = SecondTableView;
        tableView.delegate = FirstTableView;
        tableView2.delegate = SecondTableView;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        tableView2.separatorStyle = UITableViewCell.SeparatorStyle.none;
        
        //add subviews to the main view
        view.addSubview(btnLogin);
        view.addSubview(labelpresent);
        view.addSubview(labelpast);
        view.addSubview(tableView);
        view.addSubview(tableView2);
        view.addSubview(btnLogin2);
        
        //add navigation bar item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
        
        //fetch shopping list
        fetchShoppingList();
    }
    
    //place all the views in certain positions
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        labelpresent.frame = CGRect(x:30, y:110, width:view.bounds.size.width, height:50);
        tableView.frame = CGRect(x:0, y:150, width:view.bounds.size.width, height:200);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:400, width:view.bounds.size.width/1.5, height:30);
        labelpast.frame = CGRect(x:30, y:420, width:view.bounds.size.width, height:50);
        tableView2.frame = CGRect(x:0, y:470, width:view.bounds.size.width, height:200);
        btnLogin2.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:670, width:view.bounds.size.width/1.5, height:30);
        

    }

    //get all the shopping lists from the database
    func fetchShoppingList()
    {
        let db = DBManager();
        items = db.retrieveShoppingList()
        present = [ShoppingList]();
        past = [ShoppingList]();
        for item in items!{
            
            //get current date
            let formatter = DateFormatter();
            formatter.dateFormat = "dd/MM/yyyy"
            let someDate = formatter.date(from: item.date)!;
            
            var now = Date();
            let now1 = Calendar.current.date(byAdding: .day, value: -1, to: now)!
            
            //add date to present list for the first tableview
            if(someDate > now1)
            {
                present?.append(item)
                print(item.shopname)
            }
            else
            {
                //if it is not present then the item will be in the past
                past?.append(item)
            }
            
        }
        
        
        //reload data in tableview when called
        
        //send the data to delegates for past and present tableviews
        FirstTableView.present = present;
        SecondTableView.past = past;
        DispatchQueue.main.async{
            self.tableView.reloadData();
            self.tableView2.reloadData();
        }
    }
    

    //delegate tap menu button
    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }
    
    
    func deleteItems()
    {
        let cells = self.tableView.visibleCells as! Array<CustomTableViewCell2>
        
        //delete all the items with the switch
        var i = 0;
        for cell in cells{
            if cell._switch.isOn{
                
                //create database manager
                let db = DBManager();
                
                //delete item from database
                db.deleteShoppingListItem(objectToRemove: present![i])
            }
            i+=1;
            
        }
        
        //fetch all the items and reload the tableview after items have been deleted
        self.fetchShoppingList();
    }

    //delete all the items which have a switch to set to true
    @objc func logInButton(){

        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete items?", preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {(action) in self.deleteItems();}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil);

    }
    
    func deleteItems2()
    {
        let cells = self.tableView2.visibleCells as! Array<CustomTableViewCell2>
        var i = 0;

        
        //delete all the items which are on the switch
        for cell in cells{
            if cell._switch.isOn{
                let db = DBManager();
                db.deleteShoppingListItem(objectToRemove: past![i])
            }
            i+=1;
            
        }
        
        //fetch the shopping list and reload the data
        self.fetchShoppingList();
    }
    
    //delete all the items for the past shopping lists
    @objc func logInButton2(){

        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete items?", preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {(action) in self.deleteItems2();}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil);
        

    }
    
    
    //first tableview delegate for the past items
    class FirstTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
        public var present:[ShoppingList]?
        
        
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            

        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if (tableView.cellForRow(at: indexPath) as? CustomTableViewCell2) != nil{
    //            let groceryitem = self.items![indexPath.row]
    //            let vc = ModGroceryItemViewController();
    //            vc.groceryitem = groceryitem;
    //            vc.modalPresentationStyle = .fullScreen;
    //            self.present(vc,animated: false, completion: nil)
            }

        }
        
        //tableview item count
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.present?.count ?? 0;
        }
        
        
        //set customizable tableview cell for each cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell2.identifier, for: indexPath) as? CustomTableViewCell2 else{
                return UITableViewCell();
            }
            let itemSelf = self.present![indexPath.row]
            cell.configure(item: itemSelf)
            return cell;
            
        }
        
        //size of the tableview
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100;
        }
        

        
    }
    
    
    //second table view datasource
    class SecondTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{

        

        //past items retrieved from the previous page
        public var past:[ShoppingList]?

        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            

        }

        //table view count
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.past?.count ?? 0;
        }
        
        //set and configure customizable tableview items
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell2.identifier, for: indexPath) as? CustomTableViewCell2 else{
                return UITableViewCell();
            }
            let itemSelf = self.past![indexPath.row]
            cell.configure(item: itemSelf)
            return cell;
            
        }
        
        //tableview cell height
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100;
        }
    }
}
