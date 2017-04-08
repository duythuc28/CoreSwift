//
//  TSLeftMenuViewController.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/8/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class TSLeftMenuViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    lazy var listMenu: [LeftMenuData] = {
        let data = [LeftMenuData(imageName: "left_menu_home", title: "Home"),
                    LeftMenuData(imageName: "left_menu_checkin", title: "Check In"),
                    LeftMenuData(imageName: "left_menu_timesheet", title: "Time Sheet"),
                    LeftMenuData(imageName: "left_menu_logout", title: "Log out")]
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - TableView Datasource
extension TSLeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.leftMenu) as? TSLeftMenuCell ?? TSLeftMenuCell()
        cell.configureCell(value: listMenu[indexPath.row])
        return cell
    }
}


// MARK: - Tableview delgate
extension TSLeftMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(NibName.leftMenuHeader, owner: nil, options: nil)?.first as! TSHeaderLeftMenu
        return headerView
    }
}

// MARK: - Private methods
extension TSLeftMenuViewController {
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: NibName.leftMenuCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.leftMenu)
    }
    
    fileprivate struct TableViewStyles {
//        static let topPadding:CGFloat = 50
//        static let headerHeight:CGFloat = 44.0
//        static let cellHeight: CGFloat = 44.0
    }
    
//    fileprivate func 
}
