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
        return TableViewStyles.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewStyles.headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(NibName.leftMenuHeader, owner: nil, options: nil)?.first as! TSHeaderLeftMenu
        headerView.configureHeader(profileName: "Allan Pham", email: "test01@gmail.com")
        headerView.didSelectProfile = { 
            // Go to profile
            print("Profile picture click")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Go to home
            break
        case 1:
            // Go to check in
            let storyBoard = UIStoryboard(name: Storyboards.checkIn, bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "TSCheckInViewController")
            _ = self.navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            // Go to time sheet
            let storyBoard = UIStoryboard(name: Storyboards.timesheet, bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "TSTimeSheetViewController")
            _ = self.navigationController?.pushViewController(controller, animated: true)
            break
        case 3:
            // Logout
            logout()
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private methods
extension TSLeftMenuViewController {
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: NibName.leftMenuCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.leftMenu)
    }
    
    fileprivate struct TableViewStyles {
        static let headerHeight:CGFloat = 180 * Constants.RATIO_HEIGHT
        static let cellHeight: CGFloat = 60 * Constants.RATIO_HEIGHT
    }
    
    fileprivate func logout() {
        // TODO: Implement web service for logout user
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
