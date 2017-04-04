//
//  TSLoginViewController.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/3/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class TSLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonClick(_ sender: Any) {
        // FIXME: This is a test login 
        RequestManager.shared.login(email: "admin@gmail.com", password: "123456") { (result) in
            switch result {
            case .success(let token):
                Cached.token = token.token
                print("Success : \(Cached.token)")
                break
            case .failure(let error):
                print("Error : \(error.responseMessage)")
                break
            }
        }
    }

}
