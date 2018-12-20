//
//  SignInViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    let userDefault = UserDefaults.standard
    let signInAPI = SignInAPI()
    var result = ""
    
    
    public let accountEmailKey = "AccountEmailKey"
    public let accountPasswordKey = "AccountPasswordKey"
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func signInButton(_ sender: UIButton){
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            alertFunction()
        } else {
            signInAPI.signIn(emailTextField.text!, passwordTextField.text!, call: {(result) in
                self.result = result
                DispatchQueue.main.sync {
                    if self.result == "true"{
                        self.sccessAlertFunction()
                    } else {
                        self.alertFunction()
                    }
                }
            })
        }
        
    }
    
    func sccessAlertFunction(){
        let sccessAlertController = UIAlertController(title: "登入成功", message: "點擊OK繼續", preferredStyle: .alert)
        let sccessAlertAction = UIAlertAction(title: "OK", style: .default) { (enterTheGame) in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntoTheGame")
            self.navigationController?.pushViewController(homeVC, animated: true)
            print("SCCESS")
        }
        sccessAlertController.addAction(sccessAlertAction)
        present(sccessAlertController, animated: true, completion: nil)
    }
    
    func alertFunction(){
        let signInAlert = UIAlertController(title: "錯誤", message: "帳號或密碼錯誤", preferredStyle: .alert)
        let signInAlertAction = UIAlertAction(title: "OK", style: .default) { (cleanTextField) in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        }
        signInAlert.addAction(signInAlertAction)
        present(signInAlert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
