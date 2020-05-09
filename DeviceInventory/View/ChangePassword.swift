//
//  ChangePassword.swift
//  DeviceInventory
//
//  Created by Dhanshri Pawar on 29/04/20.
//  Copyright © 2020 Dhanshri Pawar. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController, ChangePasswordProtocol {
    
    var storyBoardFromChangePasswordPage: UIStoryboard?
    var viewFromChangePasswordPage: UIView?
    var errorTextFieldFromChangePasswordPage: UILabel?

    let changePasswordPresenter = ChangePasswordPresenter()
  
    @IBOutlet weak var changePasswordNewPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Change Password Page as delegate to its Presenter and Set storyboard and view for redirection purpose.
        errorLabel.alpha = 0
        changePasswordPresenter.changePasswordDelegate = self
        storyBoardFromChangePasswordPage = storyboard
        viewFromChangePasswordPage = view
        
    }
    
    // When Change Password button is pressed, the value is sent to presenter for validation updation.
    @IBAction func confirmChangingPasswordButton(_ sender: UIButton) {
        errorTextFieldFromChangePasswordPage = errorLabel
        changePasswordPresenter.newPasswordFromChangePasswordPage = changePasswordNewPasswordTextField.text!
        changePasswordPresenter.whenChangePasswordButtonPressed()
    }

    // This function will show an alert on successfull updation of password.
    func showAlert() {
        let alert = UIAlertController(title: "Successfull", message: "Password changed Succesfully", preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (saveAction) in
        self.changePasswordPresenter.redirectToPlatformSelectionPage()
        }
        alert.addAction(OkAction)
        present(alert, animated: true, completion: nil)
    }
}
