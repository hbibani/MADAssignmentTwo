//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol ModGroceryItemChildViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}

class ModGroceryItemChildViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //get context for database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    //create image view button
    var myImageView: UIImageView!;
    
    //show image button
    var showImagePicketButton: UIButton!
    
    //grocery item to modify
    var groceryitem: GroceryItem!;
    
    //get content view of the page
    private let loginContentView:UIView = {
      let view = UIView()
      //view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      return view
    }()

    //Set parameters for Name label
    private let labelname: UILabel = {
        let label = UILabel();
        label.text = "Name";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    
    //set parameter for UI Label for identification
    private let labelquantity: UILabel = {
        let label = UILabel();
        label.text = "Identification";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()
    
    
    //regex label under-neath the textfields
    private let RegEx: UILabel = {
        let label = UILabel();
        label.isHidden = false;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()
    
    
    //regex label under-neath the textfields

    private let RegEx2: UILabel = {
        let label = UILabel();
        label.isHidden = false;
        label.font = UIFont(name: "Arial", size: 12);
        label.textColor = .red;
        return label
    }()


    //UI label for image
    private let labeldate: UILabel = {
        let label = UILabel();
        label.text = "Image";
        label.font = .systemFont(ofSize: 17, weight: .bold);
        return label
    }()

    
    //UI-text field for name set parameters
    private let nameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = ""
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()

    
    //set parameters for the UItextfield
    private let idTxtField:UITextField = {
        let txtField = UITextField()
        txtField.placeholder = ""
        txtField.borderStyle = .roundedRect
        //txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()

    //set paramters for datepicker
    private let datepicker: UIDatePicker = {
        let date = UIDatePicker();
        date.timeZone = NSTimeZone.local;
        date.backgroundColor = UIColor.white;
        date.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged);
        return date;
    }()

    
    //set parameters for modification button
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Modify Grocery Item", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    //set parameters for picking image button
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



    weak var delegate: ModGroceryItemChildViewControllerDelegate?;

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Modify Grocery Item";
        // Position and add it to the first page.
        
        //add all the subviews to the UIview
        loginContentView.addSubview(labelname);
        loginContentView.addSubview(nameTxtField)
        loginContentView.addSubview(labelquantity);
        loginContentView.addSubview(idTxtField)
        loginContentView.addSubview(labeldate);
        loginContentView.addSubview(datepicker)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(btnImage)
        loginContentView.addSubview(RegEx)
        loginContentView.addSubview(RegEx2)
        view.addSubview(loginContentView)
        setupImageView();
        //set all the places of the Views on the page
        setUpAutoLayout();
        
        //set navigation bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target:self, action:#selector(didTapMenuButton));
    }

    @objc func didTapMenuButton()
    {
        delegate?.didTapMenuButton();
        
    }

    //set imageview
    func setupImageView()
    {
        myImageView = UIImageView()
        myImageView.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:310, width:view.bounds.size.width/1.5, height:200);
        loginContentView.addSubview(myImageView)
    }
    
    //set all the positions of the views on the page
    func setUpAutoLayout()
    {
        labelquantity.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:110, width:view.bounds.size.width/1.5, height:30);
        idTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:150, width:view.bounds.size.width/1.5, height:30);
        RegEx.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:170, width:view.bounds.size.width/1.5, height:30);
        RegEx.isHidden = true;
        labelname.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:190, width:view.bounds.size.width/1.5, height:30);
        loginContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height);
        nameTxtField.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:230, width:view.bounds.size.width/1.5, height:30);
        nameTxtField.text = groceryitem.name;
        idTxtField.text = groceryitem.id;
        RegEx2.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:250, width:view.bounds.size.width/1.5, height:30);
        RegEx2.isHidden = true;
        labeldate.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2-30, y:280, width:view.bounds.size.width/1.5, height:30);
        btnImage.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:530, width:view.bounds.size.width/1.5, height:30);
        btnLogin.frame = CGRect(x:(view.bounds.size.width-view.bounds.size.width/1.5)/2, y:580, width:view.bounds.size.width/1.5, height:30);
        self.myImageView.image = UIImage(data: groceryitem.image);
        
        
    }

    //modify the values when button click and check regex
    @objc func logInButton(){
        
        //get items from inputs
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
        
        // if all is good modify the item
        if RegEx.isHidden != false && RegEx2.isHidden != false
        {
            //create database manager and then modify
            let db = DBManager();
            db.modifyGroceryItem(item: self.groceryitem, name: name!, id: id!, image: pngImg!)
        }
        


    }

    
    //when date is changed in the picker then store it in date string
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date);
        print("Selected value \(selectedDate)");

    }


    //diaply the image picker
    @objc func displayImagePicker(_ sender:UIButton!) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }

    
    //image picker controller which allows you to pick image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        myImageView.image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.dismiss(animated: true, completion: nil)
    }


}
