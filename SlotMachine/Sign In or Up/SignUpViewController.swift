//
//  SignUpViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    let userDefault = UserDefaults.standard
    let signUpAPI = SignUpAPI()
    var result = ""
    let coinchange = CoinsChange()
    var userToken = ""
    let tokenKey = "TokenKey"
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmationTextField: UITextField!
    
    @IBAction func signUpButton(_ sender: UIButton){
        if (nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || passwordConfirmationTextField.text == "") || (passwordTextField.text != passwordConfirmationTextField.text) {
            alertFunction()
        } else {
            signUpAPI.signUp(nameTextField.text!, emailTextField.text!, passwordTextField.text!, passwordConfirmationTextField.text!) { (result) in
                self.result = result
                self.userToken = self.userDefault.value(forKey: self.tokenKey) as! String
                if self.result == "true" {
                    self.coinchange.addCoin("500", self.userToken, "Sign Up", call: { (icons) in
                        print("500 get")
                    })
                    self.createSccessAlertFunction()
                } else {
                    self.alertFunction()
                }
            }
        }
    }
    
    func alertFunction(){
        let signUnAlert = UIAlertController(title: "錯誤", message: "請檢查欄位", preferredStyle: .alert)
        let signUnAlertAction = UIAlertAction(title: "OK", style: .default) { (cleanTextField) in
            self.nameTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.passwordConfirmationTextField.text = ""
        }
        signUnAlert.addAction(signUnAlertAction)
        present(signUnAlert, animated: true, completion: nil)
    }
    
    func createSccessAlertFunction(){
        let sccessAlert = UIAlertController(title: "創建成功", message: "按下OK登入", preferredStyle: .alert)
        let sccessAlertAction = UIAlertAction(title: "OK", style: .default) { (sccessAlert) in
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntoTheGame")
            self.navigationController?.pushViewController(homeVC, animated: true)
            
//            self.userToken = self.userDefault.value(forKey: self.tokenKey) as! String
            
            
            
        }
        sccessAlert.addAction(sccessAlertAction)
        present(sccessAlert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
