//
//  UBLoginViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/4/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit
import Material

class UBLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: ErrorTextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // Setup email textfield
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.addLeftIcon(UIImage(named: "login_email"), frame: CGRect(x: 0, y: 0, w: 28, h: 28), imageSize: CGSize(width: 28, height: 28))
        emailTextField.detail = "Error, incorrect email!"
        emailTextField.detailColor = UIColor.red
        emailTextField.delegate = self
        // Setup password textfield
        passwordTextField.textColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.addLeftIcon(UIImage(named: "login_password"), frame: CGRect(x: 0, y: 0, w: 28, h: 28), imageSize: CGSize(width: 28, height: 28))
        // Sign In button
        signInButton.layer.cornerRadius = 20 * Constants.RATIO_WIDTH
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Private methods
    fileprivate func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    fileprivate func isValidPassword(password: String) -> Bool {
        return true
    }
    
    fileprivate func login(credential: Credential) {
        RequestManager.shared.login(credential: credential) { (result) in
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
    
    // MARK: - Action
    @IBAction func loginButtonClick(_ sender: Any) {
        if isValidEmail(email: emailTextField.text!) {
            emailTextField.isErrorRevealed = false
            let credential = Credential(email: emailTextField.text!, password: passwordTextField.text!)
            login(credential: credential)
        } else {
            emailTextField.isErrorRevealed = true
        }
    }
}

extension UBLoginViewController: TextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = !self.isValidEmail(email: textField.text!)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
//
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//       (textField as? ErrorTextField)?.isErrorRevealed = !(textField.text! == "")
        return true
    }
}
