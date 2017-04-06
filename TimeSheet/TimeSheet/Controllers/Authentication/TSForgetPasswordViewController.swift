//
//  TSForgetPasswordViewController.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/7/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit
import Material

class TSForgetPasswordViewController: UIViewController {

    @IBOutlet weak var sendEmailButtonClick: UIButton!
    @IBOutlet weak var emailTextField: ErrorTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func sendEmailButtonClick(_ sender: Any) {
        // TODO: Call WS to send email
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension TSForgetPasswordViewController {
    fileprivate func setupView() {
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.addLeftIcon(UIImage(named: "login_email"), frame: CGRect(x: 0, y: 0, w: 28, h: 28), imageSize: CGSize(width: 28, height: 28))
        emailTextField.detail = "Error, incorrect email!"
        emailTextField.detailColor = UIColor.red
        emailTextField.delegate = self
        sendEmailButtonClick.layer.cornerRadius = 20 * Constants.RATIO_WIDTH
    }
}

// MARK: Textfield Delegate
extension TSForgetPasswordViewController: TextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = !Utilities.isValidEmail(email: textField.text!) && textField.text != ""
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
