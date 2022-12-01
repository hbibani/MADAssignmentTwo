//
//  ModShoppingListChildViewController.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 1/10/22.
//

import UIKit

//did tap menu button interface for toggling menu button
protocol ModShoppingListChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}

class ModShoppingListChildViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    
    //get context for the database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    //store shopping list item to modify
    var shoppingListItem: ShoppingList!;
    
    
    //Main UI-view added to the view
    private let loginContentView:UIView = {
      let view = UIView()
      //view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      return view
    }()
    
    //Label for shop name
    private let labelshop: UILabel = {
        let label = UILabel();
        label.text = "Shop Name";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //Label for location
    private let labellocation: UILabel = {
        let label = UILabel();
        label.text = "Location";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //Label for the date
    private let labeldate: UILabel = {
        let label = UILabel();
        label.text = "Date";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //Label for ID
    private let labelid: UILabel = {
        let label = UILabel();
        label.text = "Identification";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //Regex label for id
    private let RegEx: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    
    //Regex Label for shopname
    private let RegEx2: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()

    
    //Regex for location
    private let RegEx3: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    //Input text field for shop
    private let shopnameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private let locationTxtField:UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()
    
    private let datepicker: UIDatePicker = {
        let date = UIDatePicker();
        date.timeZone = NSTimeZone.local;
        date.backgroundColor = UIColor.white;
        date.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged);
        return date;
    }()
    
    //modify button
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Modify Shopping List", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //Identify information input textfield
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
        title = "Add Shopping List";
        // Position and add it to the first page.
        
        //add subviews to UIview
        loginContentView.addSubview(labelshop);
        loginContentView.addSubview(shopnameTxtField)
        shopnameTxtField.text = shoppingListItem.shopname;
        loginContentView.addSubview(labellocation);
        loginContentView.addSubview(locationTxtField)
        locationTxtField.text = shoppingListItem.location
        loginContentView.addSubview(labeldate);
        loginContentView.addSubview(datepicker)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(RegEx)
        loginContentView.addSubview(RegEx2)
        loginContentView.addSubview(RegEx3)
        loginContentView.addSubview(idTxtField);
        idTxtField.text = shoppingListItem.id;
        loginContentView.addSubview(labelid);
        
        //setup the date and date formatter
        let formatter = DateFormatter();
        formatter.dateFormat = "dd/MM/yyyy"
        let now = formatter.date(from: shoppingListItem.date)
        dateString = formatter.string(from: now!);
        datepicker.setDate(now!, animated: false);
        view.addSubview(loginContentView)
        setUpAutoLayout();
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
    }
    
    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }
    
    
    //place the views in the view through CGRect
    func setUpAutoLayout()
    {
        labelid.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:110, width:view.bounds.size.width/1.5, height:30);
        idTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:150, width:view.bounds.size.width/1.5, height:30);
        RegEx.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:170, width:view.bounds.size.width/1.5, height:30);
        labelshop.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:190, width:view.bounds.size.width/1.5, height:30);
        loginContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height);
        shopnameTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:230, width:view.bounds.size.width/1.5, height:30);
        RegEx2.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:250, width:view.bounds.size.width/1.5, height:30);
        labellocation.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:270, width:view.bounds.size.width/1.5, height:30);
        locationTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:310, width:view.bounds.size.width/1.5, height:30);
        RegEx3.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:330, width:view.bounds.size.width/1.5, height:30);
        labeldate.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:350, width:view.bounds.size.width/1.5, height:30);
        datepicker.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:390, width:view.bounds.size.width/1.5, height:30);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:430, width:view.bounds.size.width/1.5, height:30);
        
    }
    
    
    //modify button
    @objc func logInButton(){
        
        //get values to check before modifying
        let name = shopnameTxtField.text;
        let id = idTxtField.text;
        let location = locationTxtField.text;
        let date = dateString!;
        
        //set regex to hidden
        self.RegEx.isHidden = true;
        self.RegEx2.isHidden = true;
        self.RegEx3.isHidden = true;
        
        
        //Check reg-ex items
        if id!.count == 0
        {
            self.RegEx.text = "Please Enter Id";
            self.RegEx.isHidden = false;
        }
        
        //check if name size is not zero
        if name!.count == 0
        {
            self.RegEx2.text = "Please Enter Shop Name";
            self.RegEx2.isHidden = false;
        }
        
        //check if location size is not zero
        if location!.count == 0
        {
            self.RegEx3.text = "Please Enter Location";
            self.RegEx3.isHidden = false;
        }
    
        //if everything is good then add to database
        if RegEx.isHidden != false && RegEx2.isHidden != false && RegEx3.isHidden != false
        {

            //create database manager
            let db = DBManager();
            //modify item
            db.modifyShoppingListItem(item: self.shoppingListItem, name: name!, id: id!, location: location!, date: date)
        }

    }
    
    //date picker value changed as needed
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateString = dateFormatter.string(from: sender.date);
    }

}
