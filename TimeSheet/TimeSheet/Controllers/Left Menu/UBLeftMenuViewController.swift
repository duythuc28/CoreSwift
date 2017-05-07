//
//  UBLeftMenuViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit

final class UBLeftMenuViewController: UIViewController {

    struct TableViewStyles {
        static let topPadding:CGFloat = 50
        static let headerHeight:CGFloat = 44.0
        static let cellHeight: CGFloat = 44.0
    }
    
    // MARK: - App properties
    @IBOutlet weak var tableView: UITableView!
    // TODO: Will try to add mockup images 
    lazy var sections:[LeftMenuSection] = {
        let sections = [
            LeftMenuSection(name: "Publish", items: ["New Post", "Ready to post", "Media Gallery"]),
            LeftMenuSection(name: "Converse", items: []),
            LeftMenuSection(name: "Analyze", items: ["Post", "Page"]),
            LeftMenuSection(name: "Parameters", items: ["About Us", "Logout"])
        ]
        return sections
    }()
    
    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: NibName.leftMenuCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.leftMenu)
        tableView.separatorColor = UIColor.clear
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: TableViewStyles.topPadding))
        headerView.backgroundColor = UIColor(hexString: Styles.Color.leftMenu)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor(hexString: Styles.Color.leftMenu)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view datasource
extension UBLeftMenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.leftMenu) as? UBLeftMenuCell ?? UBLeftMenuCell()
        cell.configureCell(value: sections[indexPath.section].items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewStyles.headerHeight
    }

}

// MARK: - Table view delegate
extension UBLeftMenuViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? UBLeftMenuHeaderView ?? UBLeftMenuHeaderView(reuseIdentifier: "header")
        header.setupHeader(title: sections[section].name, imageName: sections[section].imageName, section: section)
        header.headerDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].collapsed! ? 0 : TableViewStyles.cellHeight
    }
}

extension UBLeftMenuViewController: CollapsibleTableViewHeaderDelegate {
    internal func toggleSection(header: UBLeftMenuHeaderView, section: Int) {
        let collapsed = !sections[section].collapsed
        // Toggle collapse
        sections[section].collapsed = collapsed
        // Adjust the height of the rows inside the section
        tableView.beginUpdates()
        for i in 0 ..< sections[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)] , with: .automatic)
        }
        tableView.endUpdates()
    }
}
