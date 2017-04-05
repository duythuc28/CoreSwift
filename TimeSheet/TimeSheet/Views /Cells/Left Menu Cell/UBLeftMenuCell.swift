//
//  UBLeftMenuCell.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class UBLeftMenuCell: UITableViewCell {
    // MARK: - Outlet properties
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel! {
        didSet {
            notificationLabel.layoutIfNeeded()
            notificationLabel.layer.cornerRadius = notificationLabel.frame.size.width/2
            notificationLabel.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor(hexString: Styles.Color.leftMenu)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UBLeftMenuCell: CellProtocol {
    func configureCell<T>(value: T) {
        titleLabel.text! = value as! String
        // FIXME: Hard code for temporary 
        notificationLabel.isHidden = value as! String != "Ready to post"
    }
}
