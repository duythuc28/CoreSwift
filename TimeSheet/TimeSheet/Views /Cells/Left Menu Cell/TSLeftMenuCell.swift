//
//  TSLeftMenuCell.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/8/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class TSLeftMenuCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TSLeftMenuCell: CellProtocol {
    func configureCell<T>(value: T) {
        guard let data = value as? LeftMenuData else {
            print("Error in cell")
            return
        }
        titleLabel.text! = data.title
        iconImageView.image = UIImage(named: data.imageName)
    }
}
