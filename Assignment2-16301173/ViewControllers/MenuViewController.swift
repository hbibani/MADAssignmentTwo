//
//  MenuViewController.swift
//  Assignment3
//
//  Created by Heja Bibani on 17/8/22.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject{
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions)
}


//set the menu view controller using tableview layout
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    weak var delegate: MenuViewControllerDelegate?

    //menu option values
    enum MenuOptions: String, CaseIterable{
        case home = "Shopping List";
        case info = "Grocery List"
        case appRating = "Add Shopping List"
        case shareApp = "Add Grocery Item"
        
        //set images for all the buttons
        var imageName: String{
            switch self {
            case .home:
                return "number.square.fill"
            case .info:
                return "number.square"
            case .appRating:
                return "plus.square"
            case .shareApp:
                return "plus.square.fill"
            }
        }
    }
    
    //add table view for the selection of items
    private let tableView: UITableView = {
        let table = UITableView();
        table.backgroundColor = nil;
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table;
    }()
    
    
    //add images to the view
    private let myImageView: UIImageView = {
        let catImage = UIImage(systemName: "cart");
        let myView:UIImageView = UIImageView();
        myView.contentMode = UIView.ContentMode.scaleAspectFit;
        myView.frame.size.width = 180;
        myView.frame.size.height = 180;
        myView.image = catImage;
        return myView;
    }()
    
    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1);
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the tableview and imageview to the page
        view.addSubview(myImageView);
        view.addSubview(tableView)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isScrollEnabled = false;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        view.backgroundColor = greyColor;

    }
    
    //set the tableview when the layout is presented
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        tableView.frame = CGRect(x: 0, y: 200, width: view.bounds.size.width, height: view.bounds.size.height);
    }
    
    //Table
    //Get the count of items in the menu option for tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count;
        
    }
    
    //set the cells on the page to the images needed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath);
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue;
        cell.backgroundColor = greyColor;
        cell.textLabel?.textColor = .white;
        //set image to the values set in the menu options parameters
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white;
        cell.contentView.backgroundColor = greyColor;
        return cell;
    }
    
    //when item is pressed go to selected place
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelectMenuItem(menuItem: item)
    }

}
