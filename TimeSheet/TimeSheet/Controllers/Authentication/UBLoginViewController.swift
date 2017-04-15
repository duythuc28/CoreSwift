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
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    var isEmailError: Bool = false {
        didSet {
            self.emailTextField.isErrorRevealed = isEmailError
            isEmailError == true ? move(position: 25) : move(position: 15)
        }
    }
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        emailTextField.text = ""
        passwordTextField.text = ""
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    @IBAction func loginButtonClick(_ sender: Any) {
        if Utilities.isValidEmail(email: emailTextField.text!) {
            isEmailError = false
            let credential = Credential(email: emailTextField.text!, password: passwordTextField.text!)
            login(credential: credential)
        } else {
            isEmailError = true
        }
//        let credential = Credential(email: emailTextField.text!, password: passwordTextField.text!)
//        login(credential: credential)
    }
}
// MARK: - Private methods
extension UBLoginViewController {
    
    fileprivate func setupView() {
        // Setup email textfield
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.placeholderAnimation = .hidden
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
        passwordTextField.placeholderAnimation = .hidden
        passwordTextField.dividerActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.addLeftIcon(UIImage(named: "login_password"), frame: CGRect(x: 0, y: 0, w: 28, h: 28), imageSize: CGSize(width: 28, height: 28))
        // Sign In button
        signInButton.layer.cornerRadius = 20 * Constants.RATIO_WIDTH
    }
    
    fileprivate func move(position: CGFloat) {
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { [unowned self] () -> Void in
                        self.passwordTopConstraint.constant = position
                        self.view?.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func login(credential: Credential) {
        signInButton.isEnabled = false
        RequestManager.shared.login(credential: credential) { [unowned self] (result) in
            switch result {
            case .success(let token):
                print ("Token \(token)")
                // TODO: Get user info
                let homeStoryboard = UIStoryboard(name: Storyboards.home , bundle: nil)
                let containerViewController = homeStoryboard.instantiateViewController(withIdentifier: ControllerIdentifier.container)
                self.navigationController?.pushViewController(containerViewController, animated: true)
                break
            case .failure(let error):
                print ("Error \(error.responseMessage)")
                break
            }
            self.signInButton.isEnabled = true
        }
    }
}

// MARK: - Text field delegate
extension UBLoginViewController: TextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEmailError = !Utilities.isValidEmail(email: textField.text!) && textField.text != ""
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isEmailError = false
        return true
    }
//
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//       (textField as? ErrorTextField)?.isErrorRevealed = !(textField.text! == "")
        return true
    }
}
