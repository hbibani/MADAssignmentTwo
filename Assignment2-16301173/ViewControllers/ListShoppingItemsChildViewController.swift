//
//  ListShoppingItemsChildViewController.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 1/10/22.
//

import UIKit

protocol ListShoppingItemsChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}


class ListShoppingItemsChildViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //create first table view
    var FirstTableView: FirstTableViewDataSource = FirstTableViewDataSource();

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    
    //Grocery item
    var items:[GroceryItem] = Array();
    
    //store items for search function
    var itemsA:[ShoppingListItem] = Array();
    
    //store items for search function
    var items2:[ShoppingListItem] = Array();
    
    //store items for search function
    var stringItems: [String] = Array();
    
    //original items from grocery items
    var originalItems: [String] = Array();
    
    //store items for search function
    var stringItems2: [GroceryItem] = Array();
    
    //chosen item from the search function page
    var chosenItem: GroceryItem?
    
    //shopping list to add or delete item to
    var shoppingList: ShoppingList?
    
    
    
    //main content view to add
    private let loginContentView:UIView = {
      let view = UIView()
      //view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      return view
    }()
    
    //UI Label for grocery item
    private let labelshop: UILabel = {
        let label = UILabel();
        label.text = "Grocery Item";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //UI label for quantity
    private let labellocation: UILabel = {
        let label = UILabel();
        label.text = "Quantity";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //stepper to pick quantity
    let stepper: UIStepper = UIStepper();
    
    //Set UI label parameters
    private let textField6:UILabel = {
        let textField = UILabel();
        textField.text = "0";
        textField.font = .systemFont(ofSize: 20, weight: .bold);
        return textField;
    }()
    
    //set parameters for grocery list label
    private let labelgrocerylist: UILabel = {
        let label = UILabel();
        label.text = "Grocery List";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    //set regex parameters for view
    private let RegEx2: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()

    //set regex parameters for view
    private let RegEx3: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    //set table view parameters
    private let tableView: UITableView = {
        let tableView = UITableView();
        tableView.register(CustomTableViewCell3.self, forCellReuseIdentifier: CustomTableViewCell3.identifier)
        tableView.isUserInteractionEnabled = true;
        tableView.allowsSelection = false;
        return tableView;
    }()
    
    //set tablevie parameters
    private let tableGroceryList: UITableView = {
        let tableView = UITableView();
        tableView.register(CustomTableViewCell4.self, forCellReuseIdentifier: CustomTableViewCell4.identifier)
        tableView.isHidden = true;
        return tableView;
    }()
    
    
    //set parameters for the shop name
    private let shopnameTxtField:UITextField = {
        let txtField = UITextField()
        
        //for search functionality
        txtField.addTarget(self, action:  #selector(searchRecords), for: .editingChanged)
        txtField.addTarget(self, action:  #selector(searchRecords2), for: .editingDidEnd)
        txtField.addTarget(self, action:  #selector(searchRecords3), for: .editingDidBegin);

        txtField.backgroundColor = .white
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    
    //set parameters for UItextfield view
    private let locationTxtField:UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()
    
    
    //set parameters for the button
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Add Shopping Item", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //sett parameters for the delete button
    let deleteBtn:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Delete", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //set parameters for the UI textfield
    private let idTxtField:UITextField = {
        let txtField = UITextField()
        txtField.placeholder = ""
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    weak var delegate: AddGroceryListChildViewControllerDelegate?;
    var dateString: String?;
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        
        //set the parameters for the stepper
        stepper.autorepeat = true;
        stepper.minimumValue = 0;
        stepper.maximumValue = 100;
        
        //add selector
        stepper.addTarget(self, action: #selector(onChangeStepper), for: .touchUpInside)
        
        title = "Add Shopping Item";
        // Position and add it to the first page.
        
        //add views to the main UIview
        loginContentView.addSubview(labelshop);
        loginContentView.addSubview(shopnameTxtField)
        loginContentView.addSubview(labellocation);
        loginContentView.addSubview(stepper);
        loginContentView.addSubview(textField6);
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(deleteBtn)
        loginContentView.addSubview(RegEx3)
        loginContentView.addSubview(RegEx2)
        loginContentView.addSubview(tableView);
        loginContentView.addSubview(labelgrocerylist)
        loginContentView.addSubview(tableGroceryList);
        
        //set delegates for the tableview
        tableView.dataSource = FirstTableView;
        tableView.delegate = FirstTableView;
        tableGroceryList.dataSource = self;
        tableGroceryList.delegate = self;
        //add main UIview
        view.addSubview(loginContentView)
        setUpAutoLayout();
        
        //add navigation button and did tap menu button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
        
        //fetch grocery items from the database, for the search function in the tableview
        fetchGroceryItems();
        
        //fetch shopping list items in the second table view below
        //for all items associated with the shopping list
        fetchShoppingListItems();
        


    }

    
    //fetch grocery items from the database
    func fetchGroceryItems(){
        
        //create database
        let db = DBManager();
        
        //retrieve the items from the databae
        self.items = db.retrieveGroceryList();

        
        //store items for search functionality
        self.stringItems2 = db.retrieveGroceryList();
        DispatchQueue.main.async{
            self.tableView.reloadData();
        }
        
        //set items for other arrays for search functionality
        for items in self.items {
            self.originalItems.append(items.name);
            self.stringItems.append(items.name);
        }
    }
    
    
    //retrieve shopping list items from the database
    func fetchShoppingListItems(){
        let db = DBManager();
        items2.removeAll();
        //retrieve from database
        self.itemsA = db.retrieveShoppingListItems();
        
        //place items in list for search functionality
        for item in itemsA {
            print("\(item.shoppinglist.id) ... \(self.shoppingList!.id)")
            if item.shoppinglist == self.shoppingList!{
                items2.append(item);
            }
        }

        //reload the tableview data
        DispatchQueue.main.async{
            self.tableView.reloadData();
        }
        self.FirstTableView.present = self.items2;

        
    }
    
    //delegate the did tap menu button
    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }
    
    //set all the position of the views on the page
    func setUpAutoLayout()
    {
        labelshop.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:110, width:view.bounds.size.width/1.5, height:30);
        loginContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height);
        shopnameTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:150, width:view.bounds.size.width/1.5, height:30);
        RegEx2.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:170, width:view.bounds.size.width/1.5, height:30);
        tableGroceryList.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:190, width:view.bounds.size.width/1.5, height:100);
        labellocation.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:240, width:view.bounds.size.width/1.5, height:30);
        stepper.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:labellocation.frame.maxY, width:view.bounds.size.width/1.5, height:50);
        textField6.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2+stepper.frame.maxX, y:stepper.frame.minY-10, width:view.bounds.size.width/1.5, height:50);
        RegEx3.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:300, width:view.bounds.size.width/1.5, height:30);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:330, width:view.bounds.size.width/1.5, height:30);
        labelgrocerylist.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:370, width:view.bounds.size.width/1.5, height:30);
        tableView.frame = CGRect(x:0, y:400, width:view.bounds.size.width, height:350);
        deleteBtn.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:800, width:view.bounds.size.width/1.5, height:30);
    }
    
    
    //get the stepper function value
    @objc func onChangeStepper(){
        textField6.text =  Int(stepper.value).description;

    }
    
    //add grocery item to the page
    @objc func addButton(){
        let name = shopnameTxtField.text;
        let quantity = textField6.text;
        self.RegEx2.isHidden = true;
        self.RegEx3.isHidden = true;
        
        //check if grocery item is present
        if name!.count == 0
        {
            self.RegEx2.text = "Please Enter Grocery Item";
            self.RegEx2.isHidden = false;
        }
        
        //check if quantity is present
        if quantity == "0"
        {
            self.RegEx3.text = "Please Enter Quantity";
            self.RegEx3.isHidden = false;
        }
    
        //if all is good add the item to the database
        if RegEx2.isHidden != false && RegEx3.isHidden != false
        {
            //create database manager
            let db = DBManager();
            
            
            //add to the database
            db.addShoppingListItemToList(shoppinglist: self.shoppingList!, groceryitem: self.chosenItem!, quantity: quantity!)
            //hide the regex
            self.RegEx2.isHidden = true;
            self.RegEx3.isHidden = true;
            
            //set all the values to zero
            shopnameTxtField.text = "";
            idTxtField.text = "";
            textField6.text = "0";
            stepper.value = 0;
            //search the records again
            searchRecords(shopnameTxtField)
            tableGroceryList.isHidden = true;
            
            //fetch the items and reload tableview after completed
            self.fetchShoppingListItems();
        }

    }
    
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shopnameTxtField.resignFirstResponder()
        return true
    }
    
    //search the records in the table view
    @objc func searchRecords(_ textField: UITextField) {
        tableGroceryList.isHidden = false;

        //remove all items from strings
        self.stringItems.removeAll()
        self.stringItems2.removeAll();
        
        var i = 0;
        if textField.text?.count != 0 {

            //search for the items in the list
            for item in items {
                
                if let itemToSearch = textField.text{
                    let range = item.name.lowercased().range(of: itemToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        
                        //add the items when found
                        self.stringItems.append(item.name)
                        print(item.name);
                        self.stringItems2.append(item)
                    }
                }
                i += 1;
            }
        } else {
            for item in items {
                stringItems.append(item.name)
                self.stringItems2.append(item)
                i += 1;
            }
        }
        
        i = 0;
        
        //reload tableview of the search function when updated
        tableGroceryList.reloadData()
    }
    
    //hide the search table view when needed
    @objc func searchRecords2()
    {
        tableGroceryList.isHidden = true;
    }
    
    //hide the search table view when invoked
    @objc func searchRecords3()
    {
        tableGroceryList.isHidden = false;
    }
    
    func deleteItems()
    {
        let cells = self.tableView.visibleCells as! Array<CustomTableViewCell3>

        //delete items which are switched on from database
        var i = 0;
        for cell in cells{
            if cell._switch.isOn{
                let db = DBManager();
                db.deleteShoppingListItem(objectToRemove: self.items2[i])
            }
            i+=1;

        }
        //fetch the items again after deleting
        self.fetchShoppingListItems();
    }
    
    //delete the item from the database
    @objc func deleteButton(){

        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete items?", preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {(action) in self.deleteItems();}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil);
    }

    
    //after item is selected, search the records again to update search table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shopnameTxtField.text = stringItems[indexPath.row];
        self.chosenItem = self.stringItems2[indexPath.row];
        searchRecords(shopnameTxtField)
        shopnameTxtField.resignFirstResponder()
    }

    //return the items count in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stringItems.count
    }
    
    //set the cells with the custom table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        //get the customtable4 for the current table view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell4.identifier, for: indexPath) as? CustomTableViewCell4 else{
            return UITableViewCell();
        }
        
        //get item from items and then configure
        let itemSelf = self.stringItems2[indexPath.row]
        cell.configure(item: itemSelf)
        return cell;
        
    }


}

//tableview delegate for the second table view on the bottom of the page
class FirstTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    //get all the items in the tableview from the other page
    public var present:[ShoppingListItem]?
    
    //do nothing if selected
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        

    }

    //do nothing if pressed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (tableView.cellForRow(at: indexPath) as? CustomTableViewCell3) != nil{
//            let groceryitem = self.items![indexPath.row]
//            let vc = ModGroceryItemViewController();
//            vc.groceryitem = groceryitem;
//            vc.modalPresentationStyle = .fullScreen;
//            self.present(vc,animated: false, completion: nil)
        }

    }
    
    //return count of the size of the items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.present?.count ?? 0;
    }
    
    //set the customizable cells for the tableview below
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell3.identifier, for: indexPath) as? CustomTableViewCell3 else{
            return UITableViewCell();
        }
        
        //configure the cell
        let itemSelf = self.present![indexPath.row]
        cell.configure(item: itemSelf)
        return cell;
        
    }
    
    //height of the tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    

    
}


