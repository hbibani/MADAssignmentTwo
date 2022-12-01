//
//  CustomTableViewCell2.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 25/9/22.
//

import Foundation
import UIKit

class CustomTableViewCell3: UITableViewCell {
    
    //Gives Custom table view cell an identifier to be matched up with tableview on the view-controller
    static let identifier = "CustomTableViewCell3"
    
    //Associate each cell with a shopping list item.
    var item: ShoppingListItem?;
    
    //-----Produce all the UIViews--------------
    
    //Switch for deleting items
    public let _switch: UISwitch = {
        let _switch = UISwitch();
        _switch.onTintColor = .blue;
        _switch.isOn = true;
        return _switch;
        
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "cat1");
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        return imageView;
        
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

    //add each of the UIviews as sub-views so that it can be seen on the page
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        contentView.backgroundColor = .systemTeal;
        
        //add all the views that we added at the top the view as subviews
        contentView.addSubview(_switch);
        contentView.addSubview(myLabel);
        contentView.addSubview(myLabel2);
        contentView.addSubview(myImageView);
        contentView.isUserInteractionEnabled = true;

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //configure the cells with the right name on the labels and also the item and switch
    public func configure(item: ShoppingListItem)
    {
        self.myLabel.text = "Name: \(item.groceryitem.name)";
        self.myLabel2.text = "Quantity: \(item.quantity)";
        self.item = item;
        self._switch.setOn(false, animated: false)
        self.myImageView.image = UIImage(data: item.groceryitem.image);
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
        myImageView.frame = CGRect(x: contentView.frame.size.width-imageSize, y: 3, width: imageSize, height: imageSize)
    }

}
