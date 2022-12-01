//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by Heja Bibani on 4/9/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    var item: GroceryItem?;

    //add switch to the custom cell
    public let _switch: UISwitch = {
        let _switch = UISwitch();
        _switch.onTintColor = .blue;
        _switch.isOn = true;
        return _switch;
        
    }()
    
    //add UIimage view to the custom cell
    private let myImageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "cat1");
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        return imageView;
        
    }()
    
    //add Label
    private let myLabel: UILabel = {
        let label = UILabel();
        label.textColor = .white;
        label.font = .systemFont(ofSize: 17, weight: .bold);
        label.text = "Custom Cell"
        return label;
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        contentView.backgroundColor = .systemTeal;
        
        //add all the views as subviews to the view
        contentView.addSubview(_switch);
        contentView.addSubview(myImageView);
        contentView.addSubview(myLabel);
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //configure the custom cell on creation
    public func configure(text: String, imageData: Data)
    {
        //set the subviews information to the one desired
        self.myLabel.text = text;
        self.myImageView.image = UIImage(data: imageData);
        self._switch.setOn(false, animated: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.myLabel.text = nil;
        self.myImageView.image = nil;
    }
    
    
    //set the layout of the views
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let imageSize = contentView.frame.size.height - 6;
        let switchSize = _switch.sizeThatFits(contentView.frame.size);
        _switch.frame = CGRect(x: 5, y: (contentView.frame.size.height - switchSize.height)/2, width: switchSize.width, height: switchSize.height)
        myLabel.frame = CGRect(x: 10+_switch.frame.size.width, y: 0, width: contentView.frame.size.width - 10 - _switch.frame.size.width - imageSize, height: contentView.frame.size.height)
        myImageView.frame = CGRect(x: contentView.frame.size.width-imageSize, y: 3, width: imageSize, height: imageSize)
    }

}
