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
    
    var homeNavigationController: UINavigationController!
    var checkInViewController: UINavigationController!
    var timeSheetViewController: UINavigationController!
    var userProfileViewController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewController()
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
            self.slideMenuController()?.changeMainViewController(self.userProfileViewController, close: true)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private methods
extension TSLeftMenuViewController {
    
    fileprivate enum LeftMenu: Int {
        case home = 0
        case checkin
        case timesheet
        case logout
    }
    
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: NibName.leftMenuCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.leftMenu)
    }
    
    fileprivate func setupViewController() {
        let homeStoryboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        homeNavigationController = homeStoryboard.instantiateViewController(withIdentifier: ControllerIdentifier.homeNavigationController) as! UINavigationController
        
        let timeSheetStoryboard = UIStoryboard(name: Storyboards.timesheet, bundle: nil)
        timeSheetViewController = timeSheetStoryboard.instantiateViewController(withIdentifier: ControllerIdentifier.timesheetNavigation) as! UINavigationController
        
        let checkInStoryboard = UIStoryboard(name: Storyboards.checkIn, bundle: nil)
        checkInViewController = checkInStoryboard.instantiateViewController(withIdentifier: ControllerIdentifier.checkinNavigation) as! UINavigationController
        
        let userProfileStoryboard = UIStoryboard(name: Storyboards.userProfile, bundle: nil)
        userProfileViewController = userProfileStoryboard.instantiateViewController(withIdentifier: ControllerIdentifier.userProfileNavigation) as! UINavigationController
    }
    
    fileprivate struct TableViewStyles {
        static let headerHeight:CGFloat = 180 * Constants.RATIO_HEIGHT
        static let cellHeight: CGFloat = 60 * Constants.RATIO_HEIGHT
    }
    
    fileprivate func logout() {
        // TODO: Implement web service for logout user
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.slideMenuController()?.changeMainViewController(self.homeNavigationController, close: true)
        case .timesheet:
            self.slideMenuController()?.changeMainViewController(self.timeSheetViewController, close: true)
        case .checkin:
            self.slideMenuController()?.changeMainViewController(self.checkInViewController, close: true)
        case .logout:
            logout()
        }
    }
}
