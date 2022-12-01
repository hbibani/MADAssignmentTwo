//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by Heja Bibani on 4/9/22.
//

import UIKit

class CustomTableViewCell4: UITableViewCell {
    static let identifier = "CustomTableViewCell4"
    
    //grocery item stored for movement
    var item: GroceryItem?;

    
    //Label for storing iformation
    private let myLabel: UILabel = {
        let label = UILabel();
        label.textColor = .black;
        label.font = .systemFont(ofSize: 10, weight: .bold);
        label.text = "Custom Cell"
        return label;
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //add subview to the main view which is of the label only
        contentView.addSubview(myLabel);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //configure the custom cell when called
    public func configure(item: GroceryItem)
    {
        self.item = item;
        self.myLabel.text = item.name;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        //self.myLabel.text = nil;
    }
    
    //set layout of the subviews on the screen to position
    override func layoutSubviews() {
        super.layoutSubviews();
        myLabel.frame = CGRect(x: 0, y: 0, width: 100, height: contentView.frame.size.height-10)
    }

}
