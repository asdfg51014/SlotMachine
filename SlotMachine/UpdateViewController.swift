//
//  UpdateViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/19.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController, UITextFieldDelegate {

    let userDefault = UserDefaults.standard
    let updateAPI = UpdateAPI()
    var userToken = ""
    let tokenKey = "TokenKey"
    var result = ""
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func updateButton(_ sender: UIButton){
        
        if nameTextField.text == "" {
            failAlert()
        } else {
            updateAPI.signIn(nameTextField.text!, userToken) { (result) in
                self.result = result
                self.judgResult()
            }
        }
        
        
        
    }
    
    func failAlert(){
        let alertController = UIAlertController(title: "錯誤", message: "請輸入名稱", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func sccessAlert(){
        let alertController = UIAlertController(title: "更改成功", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (goBack) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func judgResult(){
        if result == "true" {
            sccessAlert()
        } else {
            failAlert()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userToken = userDefault.value(forKey: tokenKey) as! String
        // Do any additional setup after loading the view.
    }
    

}
