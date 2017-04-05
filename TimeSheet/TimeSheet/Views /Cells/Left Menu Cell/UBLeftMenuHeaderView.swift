//
//  UBLeftMenuHeaderView.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit
import EZSwiftExtensions

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: UBLeftMenuHeaderView, section: Int)
}

class UBLeftMenuHeaderView: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    let iconImageView = UIImageView()
    var headerDelegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hexString: Styles.Color.leftMenu)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(_:))))
        // arrowLabel must have fixed width and height
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // FIXME: Current UI Constraints does not work correctly 
        let views = [
            "titleLabel" : titleLabel,
            "arrowLabel" : arrowLabel,
            ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
            options: [],
            metrics: nil,
            views: views
        ))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[titleLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[arrowLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? UBLeftMenuHeaderView else {
            return
        }
        headerDelegate?.toggleSection(header: self, section: cell.section)
    }
    
    func setCollapsed(collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
//        arrowLabel.rotate(collapsed ? 0.0 : CGFloat(M_PI_2))
    }
    
    func setupHeader(title: String, imageName: String = "", section: Int) {
        self.titleLabel.text = title
        self.arrowLabel.text = ">"
        self.section = section
        if imageName != "" {
            self.iconImageView.image = UIImage(named: imageName)
        }
    }
}
