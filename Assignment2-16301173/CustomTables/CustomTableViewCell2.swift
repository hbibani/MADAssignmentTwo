//
//  CustomTableViewCell2.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 25/9/22.
//

import Foundation
import UIKit

class CustomTableViewCell2: UITableViewCell {
    
    //Gives Custom table view cell an identifier to be matched up with tableview on the view-controller
    static let identifier = "CustomTableViewCell2"
    
    //Associate each cell with a shopping list item.
    var item: ShoppingList?;
    
    //-----Produce all the UIViews--------------
    
    //Switch for deleting items
    public let _switch: UISwitch = {
        let _switch = UISwitch();
        _switch.onTintColor = .blue;
        _switch.isOn = true;
        return _switch;
        
    }()
    
    //Labels for name
    private let myLabel: UILabel = {
        let label = UILabel();
        label.textColor = .white;
        label.font = .systemFont(ofSize: 12, weight: .bold);
        label.text = "Custom Cell"
        return label;
        
    }()
    
    //label for location
    private let myLabel2: UILabel = {
        let label = UILabel();
        label.textColor = .white;
        label.font = .systemFont(ofSize: 12, weight: .bold);
        label.text = "Custom Cell"
        return label;
        
    }()
    
    //Label for date
    private let myLabel3: UILabel = {
        let label = UILabel();
        label.textColor = .white;
        label.font = .systemFont(ofSize: 12, weight: .bold);
        label.text = "Custom Cell"
        return label;
        
    }()
    
    //Map button configured to look for address
    lazy var btnMap:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Map", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(mapBtn), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //Button to modify shopping list item
    lazy var btnMod:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .systemPink
        btn.setTitle("Mod", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(modBtn), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //button to view list and add grocery items
    lazy var btnList:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .systemOrange
        btn.setTitle("List", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(listBtn), for: .touchUpInside)
        //btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //Go to the maps page using the location of the item associated with the cell called when map button is hit
    @objc func mapBtn()
    {

        var vc = MapViewController2();
        vc.addressmap = self.item!.location;
        vc.modalPresentationStyle = .fullScreen
        
        //get the root-view controller to move to the next page
        if var controller = window?.rootViewController {
            while let presentViewController = controller.presentedViewController{
                controller = presentViewController;
            }
            
            controller.present(vc, animated: true, completion: nil)
        }
        //self.window?.rootViewController?.present(vc, animated: false, completion: nil)
    }
    
    
    //Modificaiton button selector is called when the modify button is hit
    @objc func modBtn()
    {
        var vc = ModShoppingListViewController();
        vc.shoppingListItem = self.item;
        vc.modalPresentationStyle = .fullScreen
        
        //get the root-view controller to move to the next page
        if var controller = window?.rootViewController {
            while let presentViewController = controller.presentedViewController{
                controller = presentViewController;
            }
            controller.present(vc, animated: true, completion: nil)
        }
        
    }
    
    //Go to the list page and add button called when list button is hit
    @objc func listBtn()
    {
        var vc = ListShoppingItemsViewController();
        vc.modalPresentationStyle = .fullScreen
        vc.shoppingList = self.item;
        
        //get the root-view controller to move to the next page
        if var controller = window?.rootViewController {
            while let presentViewController = controller.presentedViewController{
                controller = presentViewController;
            }
            
            controller.present(vc, animated: true, completion: nil)
        }
    }

    //add each of the UIviews as sub-views so that it can be seen on the page
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        contentView.backgroundColor = .systemTeal;
        contentView.addSubview(_switch);
        contentView.addSubview(btnMap);
        contentView.addSubview(btnMod);
        contentView.addSubview(btnList);
        contentView.addSubview(myLabel);
        contentView.addSubview(myLabel2);
        contentView.addSubview(myLabel3);
        contentView.isUserInteractionEnabled = true;

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //configure the cells with the right name on the labels and also the item and switch
    public func configure(item: ShoppingList)
    {
        self.myLabel.text = "Name: \(item.shopname)";
        self.myLabel2.text = "Location: \(item.location)";
        self.myLabel3.text = "Date: \(item.date)";
        self.item = item;
        self._switch.setOn(false, animated: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.myLabel.text = nil;
    }
    
    
    //Place all the views in locations on the screen
    override func layoutSubviews() {
        super.layoutSubviews();
        let imageSize = contentView.frame.size.height - 6;
        let switchSize = _switch.sizeThatFits(contentView.frame.size);
        _switch.frame = CGRect(x: 5, y: (contentView.frame.size.height - switchSize.height)/2, width: switchSize.width, height: switchSize.height)
        myLabel.frame = CGRect(x: 10+_switch.frame.size.width, y: 0, width: contentView.frame.size.width - 10 - _switch.frame.size.width - imageSize, height: contentView.frame.size.height/2)
        myLabel2.frame = CGRect(x: 10+_switch.frame.size.width, y:15, width: contentView.frame.size.width - 10 - _switch.frame.size.width - imageSize, height: contentView.frame.size.height/2)
        myLabel3.frame = CGRect(x: 10+_switch.frame.size.width, y:30, width: contentView.frame.size.width - 10 - _switch.frame.size.width - imageSize, height: contentView.frame.size.height/2)
        btnMap.frame = CGRect(x: contentView.frame.size.width-imageSize, y: 10, width: contentView.frame.size.width / 4.5-10, height: contentView.frame.size.height/4.5)
        btnMod.frame = CGRect(x: btnMap.frame.minX - btnMap.frame.width - 5, y: 10, width: contentView.frame.size.width / 4.5-10, height: contentView.frame.size.height/4.5)
        btnList.frame = CGRect(x: btnMap.frame.minX - btnMap.frame.width - 5, y: btnMap.frame.height+20, width: contentView.frame.size.width / 4.5-10, height: contentView.frame.size.height/4.5)
    }

}
