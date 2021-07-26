//
//  ViewController.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 23.07.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginManager = LoginManager()
    
    var isLoginButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        textFieldEdit(userNameTextField)
        textFieldEdit(passwordTextField)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.tag = 0
        
        
    }
    
    //MARK: - TextField Editing
    func textFieldEdit(_ textField: UITextField) {
        let myColor = #colorLiteral(red: 0.4971373677, green: 0.6192893386, blue: 0.552495718, alpha: 1)
        textField.layer.borderColor = myColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 15.0
    }
    
    //MARK: - Alert Error
    
    func showAlertError() {
        let alert = UIAlertController(title: "Error", message: "The username or password that you've entered is incorrect!!!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("error")
        }))
        
        present(alert, animated: true)
    }
    
    func showAlertErrorIsEmpty() {
        let alert = UIAlertController(title: "Error", message: "Username or password cannot be left blank.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("error")
        }))
        
        present(alert, animated: true)
    }
    
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        if userName!.isEmpty || password!.isEmpty {
            showAlertErrorIsEmpty()
            userNameTextField.placeholder = "Type something"
            passwordTextField.placeholder = "Type something"
        } else {
            if (userName != nil && password != nil) {
                let isLogin = loginManager.loginApp(userName!, password!)
                if isLogin {
                    isLoginButton = true
                    userNameTextField.text = ""
                    passwordTextField.text = ""
                    performSegue(withIdentifier: "goToFriendsList", sender: self)
                } else {
                    showAlertError()
                    userNameTextField.text = ""
                    passwordTextField.text = ""
                }
            }
        }
        
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return true
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        if (userNameTextField == textField && userName!.isEmpty) || (passwordTextField == textField && password!.isEmpty) {
            if userNameTextField == textField && userName!.isEmpty {
            
            } else {
                showAlertErrorIsEmpty()
                userNameTextField.placeholder = "Type something"
                passwordTextField.placeholder = "Type something"
            }
        } else {
            if (userNameTextField == textField && userName != nil) || (passwordTextField == textField && password != nil) {
                
                if userNameTextField == textField && userName != nil {
                
                } else {
                    let isLogin = loginManager.loginApp(userName!, password!)
                    if isLogin {
                        if !isLoginButton {
                            isLoginButton = false
                            userNameTextField.text = ""
                            passwordTextField.text = ""
                            performSegue(withIdentifier: "goToFriendsList", sender: self)
                        }
                    } else {
                        showAlertError()
                        userNameTextField.text = ""
                        passwordTextField.text = ""
                    }
                }
            }
        }
        
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
}

