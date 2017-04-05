//
//  UBLoginViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/4/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit

class UBLoginViewController: UIViewController {

    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    @IBAction func loginButtonClick(_ sender: Any) {
        RequestManager.shared.login(email: "", password: "") { (result) in
            switch result {
            case .success(let token):
                print ("Token \(token)")
                break
            case .failure(let error):
                print ("Error \(error.responseMessage)")
                break
            }
        }
    }
}


// MARK: - Private methods

