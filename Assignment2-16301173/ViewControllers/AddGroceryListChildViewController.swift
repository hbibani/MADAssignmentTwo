//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol AddGroceryListChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}


class AddGroceryListChildViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //get database context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    //set the image view for picking the grocery image
    var myImageView: UIImageView!;
    var showImagePicketButton: UIButton!

    
    //set main uiview
    private let loginContentView:UIView = {
      let view = UIView()
      //view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      return view
    }()

    
    //set uilabel parameters for the name
    private let labelname: UILabel = {
        let label = UILabel();
        label.text = "Name";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    //set uilabel parameters for identification
    private let labelquantity: UILabel = {
        let label = UILabel();
        label.text = "Identification";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //set regex labels underneath input fields and parameters
    private let RegEx: UILabel = {
        let label = UILabel();
        label.isHidden = false;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    
    //set regex labels underneath input fields and parameters
    private let RegEx2: UILabel = {
        let label = UILabel();
        label.isHidden = false;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()


    
    //set UIlabel for the image
    private let labeldate: UILabel = {
        let label = UILabel();
        label.text = "Image";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    
    //set the UItextfield for the name
    private let nameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = ""
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    
    //set the UItexfield for the identification
    private let idTxtField:UITextField = {
        let txtField = UITextField()
        txtField.placeholder = ""
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()

    
    //set the datepicker for the date
    private let datepicker: UIDatePicker = {
        let date = UIDatePicker();
        date.timeZone = NSTimeZone.local;
        date.backgroundColor = UIColor.white;
        date.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged);
        return date;
    }()

    
    //set the add grocery item button
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Add Grocery Item", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()


    //set the button to pick the image
    let btnImage:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Pick Image", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()


    weak var delegate: AddShoppingChildViewControllerDelegate?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Add Grocery Item";
        
        
        
        // Position and add it to the first page.
        loginContentView.addSubview(idTxtField)
        loginContentView.addSubview(labelname);
        loginContentView.addSubview(nameTxtField)
        loginContentView.addSubview(labelquantity);
        loginContentView.addSubview(labeldate);
        loginContentView.addSubview(datepicker)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(btnImage)
        loginContentView.addSubview(RegEx)
        loginContentView.addSubview(RegEx2)

        view.addSubview(loginContentView)
        
        //set the image view
        setupImageView();
        
        //set the positon of the views on the page
        setUpAutoLayout();
        
        //set the navigation bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
    }

    //set delegate for tap menu button
    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }

    
    //set the image view on the page
    func setupImageView()
    {
        myImageView = UIImageView()
        myImageView.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:310, width:view.bounds.size.width/1.5, height:200);
        loginContentView.addSubview(myImageView)
    }

    
    //set the position of the views on the page
    func setUpAutoLayout()
    {
        labelquantity.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:110, width:view.bounds.size.width/1.5, height:30);
        idTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:140, width:view.bounds.size.width/1.5, height:30);
        RegEx.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:170, width:view.bounds.size.width/1.5, height:30);
        RegEx.isHidden = true;
        labelname.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:190, width:view.bounds.size.width/1.5, height:30);
        nameTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:230, width:view.bounds.size.width/1.5, height:30);
        RegEx2.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:250, width:view.bounds.size.width/1.5, height:30);
        labeldate.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:280, width:view.bounds.size.width/1.5, height:30);
        btnImage.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:530, width:view.bounds.size.width/1.5, height:30);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:580, width:view.bounds.size.width/1.5, height:30);
        RegEx2.isHidden = true;
        loginContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height);

    }

    //add grocery item to the database
    @objc func logInButton(){
        
        //get the values of the data
        let pngImg = myImageView.image?.pngData();
        let name = nameTxtField.text;
        let id = idTxtField.text;
        
        
        //set regex to hidden
        self.RegEx.isHidden = true;
        self.RegEx2.isHidden = true;
        
        
        //check if id is present
        if id!.count == 0
        {
            self.RegEx.text = "Please Enter Id";
            self.RegEx.isHidden = false;
        }
        
        //check if name is present
        if name!.count == 0
        {
            self.RegEx2.text = "Please Enter Name";
            self.RegEx2.isHidden = false;
        }
    
        
        //if all is good add it to database
        if RegEx.isHidden != false && RegEx2.isHidden != false{
            
   
            //create database manager object
            let db = DBManager();
            
            //add grocery item to the database
            db.addGroceryItem(name: nameTxtField.text!, id: id!, pngImg: pngImg)
            
            //hide any regex
            self.RegEx.isHidden = true;
            self.RegEx2.isHidden = true;
            
            //reset values of inputs
            nameTxtField.text = "";
            idTxtField.text = "";
            myImageView.image = nil;
        }


    }

    
    //get the date after the picker value has changed
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date);
        print("Selected value \(selectedDate)");

    }

    //display the image to pick on the page when pressed
    @objc func displayImagePicker(_ sender:UIButton!) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }

    
    //ui image picker controller to place image which was picked on the page
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        myImageView.image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.dismiss(animated: true, completion: nil)
    }


}
