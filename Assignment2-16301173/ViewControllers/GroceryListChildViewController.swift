//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol GroceryListChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}

class GroceryListChildViewController: UIViewController, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: AddShoppingChildViewControllerDelegate?;

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

    //grocery item received from other page
    var items:[GroceryItem]?
    
    
    
    //add button to page
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
    
    
    //add table view of grocery items
    private let tableView: UITableView = {
        let tableView = UITableView();
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Grocery List";
        
        //set the delegate of the tableview
        tableView.dataSource = self;
        tableView.delegate = self;
        
        //add subviews to page
        view.addSubview(btnLogin)
        view.addSubview(tableView);
        
        //add navigation bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
        
        //fetch grocery items from the database
        fetchGroceryItems();
    }
    
    //set the positions of the views on the page
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        tableView.frame = CGRect(x:0, y:0, width:view.bounds.size.width, height:650);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:700, width:view.bounds.size.width/1.5, height:30);
    }

    
    //fetch grocery items from the database
    func fetchGroceryItems(){
        let db = DBManager();
        self.items = db.retrieveGroceryList();
        DispatchQueue.main.async{
            self.tableView.reloadData();
        }
    }

    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        

    }

    //if item is selected then go to modify page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (tableView.cellForRow(at: indexPath) as? CustomTableViewCell) != nil{
            let groceryitem = self.items![indexPath.row]
            let vc = ModGroceryItemViewController();
                
            //set grocery item to modify
            vc.groceryitem = groceryitem;
            vc.modalPresentationStyle = .fullScreen;
            self.present(vc,animated: false, completion: nil)
        }

    }
    
    //set tableview count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0;
    }
    
    //set cutomizable cell for the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get the tableview cell from custom table
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else{
            return UITableViewCell();
        }
        
        //get the item
        let groceryitem = self.items![indexPath.row]
        
        
        //configure the cell
        cell.configure(text: groceryitem.name, imageData: groceryitem.image)
        return cell;
    }
    
    //table view cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    func deleteItems()
    {
        let cells = self.tableView.visibleCells as! Array<CustomTableViewCell>

        var i = 0;
        
        //all items with switch set to true will be deleted
        for cell in cells{
            if cell._switch.isOn{
                let db = DBManager();
                db.deleteGroceryItem(objectToRemove: self.items![i])
            }
            i+=1;
            
        }
        
        //reload items from the database and update tableview
        self.fetchGroceryItems();
    }
    
    //delete grocery items from database
    @objc func logInButton(){

        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete items?", preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {(action) in self.deleteItems();}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil);
    }
    
}





