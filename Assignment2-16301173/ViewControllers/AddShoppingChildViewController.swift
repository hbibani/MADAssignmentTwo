//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol AddShoppingChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}

class AddShoppingChildViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

    //add main uiview
    private let loginContentView:UIView = {
      let view = UIView()
      //view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      return view
    }()
    
    //add shop name label and set parameters
    private let labelshop: UILabel = {
        let label = UILabel();
        label.text = "Shop Name";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //add location label and set parameters
    private let labellocation: UILabel = {
        let label = UILabel();
        label.text = "Location";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //add date label and set parameters
    private let labeldate: UILabel = {
        let label = UILabel();
        label.text = "Date";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //add identification and set parameters
    private let labelid: UILabel = {
        let label = UILabel();
        label.text = "Identification";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    //regex parameters to be set under the textfield
    private let RegEx: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    
    //regex parameters to be set under the textfield
    private let RegEx2: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()

    //regex parameters to be set under the textfield
    private let RegEx3: UILabel = {
        let label = UILabel();
        label.isHidden = true;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    
    //set uitext field paramters for name of shop
    private let shopnameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    
    //set uitext field paramters for name of location

    private let locationTxtField:UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()
    
    
    //set uidate picker for the date and set parameters
    private let datepicker: UIDatePicker = {
        let date = UIDatePicker();
        date.timeZone = NSTimeZone.local;
        date.backgroundColor = UIColor.white;
        date.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged);
        return date;
    }()
    
    
    //add shoppping item button to the view and set parameters
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Add Shopping List", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //identification ui textfield and set parameters for view
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
        
        //add views to the main UIview
        loginContentView.addSubview(labelshop);
        loginContentView.addSubview(shopnameTxtField)
        loginContentView.addSubview(labellocation);
        loginContentView.addSubview(locationTxtField)
        loginContentView.addSubview(labeldate);
        loginContentView.addSubview(datepicker)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(RegEx)
        loginContentView.addSubview(RegEx2)
        loginContentView.addSubview(RegEx3)
        loginContentView.addSubview(idTxtField);
        loginContentView.addSubview(labelid);
        
        //set the date for now
        let formatter = DateFormatter();
        formatter.dateFormat = "dd/MM/yyyy"
        let now = Date();
        dateString = formatter.string(from: now);
        
        //add main UIview
        view.addSubview(loginContentView)
        
        //set the position of the views on the page
        setUpAutoLayout();
        
        //add navigation bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
    }
    
    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }
    
    
    //set the views position on the page
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
    
    
    //add shopping list to database after checking regex
    @objc func logInButton(){
        let name = shopnameTxtField.text;
        let id = idTxtField.text;
        let location = locationTxtField.text;
        let date = dateString!;
        
        //set regex to hidden
        self.RegEx.isHidden = true;
        self.RegEx2.isHidden = true;
        self.RegEx3.isHidden = true;
        
        
        //if id is not in show the regelabel
        if id!.count == 0
        {
            self.RegEx.text = "Please Enter Id";
            self.RegEx.isHidden = false;
        }
        
        //if no name,  then show the regex label
        if name!.count == 0
        {
            self.RegEx2.text = "Please Enter Shop Name";
            self.RegEx2.isHidden = false;
        }
        
        
        //if no location then show the regex label
        if location!.count == 0
        {
            self.RegEx3.text = "Please Enter Location";
            self.RegEx3.isHidden = false;
        }
    
        
        //if all is good then add to database
        if RegEx.isHidden != false && RegEx2.isHidden != false && RegEx3.isHidden != false
        {

            
            //create database manager
            let db = DBManager();
            
            //add item to the dataabase
            db.addShoppingListItem(name: shopnameTxtField.text!, id: id!, location: location!, date: date)
            
            //hide any regex
            self.RegEx.isHidden = true;
            self.RegEx2.isHidden = true;
            
            //reset the values
            shopnameTxtField.text = "";
            idTxtField.text = "";
            locationTxtField.text = "";
        }

    }
    
    
    //get date after datepicker value changed
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateString = dateFormatter.string(from: sender.date);
    }


}
