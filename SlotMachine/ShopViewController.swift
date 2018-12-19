//
//  ShopViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/19.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    let userDefault = UserDefaults.standard
    var tokenKey = "TokenKey"
    var userToken = ""
    let buyProduct = BuyItemAPI()
    let showCoin = ShowCoins()
    var userCoins = ""
    let coinChange = CoinsChange()
    var result = ""
    
    @IBOutlet var coinsLabel: UILabel!
    
    func sccessFunction(){
        let bonus = (arc4random() % 20) * 10
        let alertController = UIAlertController(title: "購買成功", message: "獲得\(bonus)金幣", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (coina) in
            
            self.coinChange.addCoin("\(bonus)", self.userToken, "Buy The Product", call: { (userCoins) in
                DispatchQueue.main.sync {
                    self.showCoinFunction()
                }
            })
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func failFunction(){
        let alertController = UIAlertController(title: "購買失敗", message: "請重新購買", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func buyProductFunction(){
        buyProduct.buyProduct(userToken, "randomBonus", "1") { (result) in
            self.result = result
            DispatchQueue.main.async {
                self.judgResult()
            }
        }
    }
    
    func judgResult(){
        if result == "true" {
            sccessFunction()
            showCoinFunction()
        } else {
            failFunction()
            showCoinFunction()
        }
    }
    
    func showCoinFunction(){
        showCoin.showCoins(userToken) { (coins) in
            DispatchQueue.main.async {
                self.coinsLabel.text = coins
            }
        }
    }
    
    
    
    @IBAction func buyTheProduct(_ sender: UIButton) {
        
        let buyAlert = UIAlertController(title: "確定購買？", message: "花費100金幣取得隨機個數金幣", preferredStyle: .alert)
        let buyAlertAction = UIAlertAction(title: "確定", style: .default) { (buy) in
            self.buyProductFunction()
        }
        let buyCancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        buyAlert.addAction(buyCancelAction)
        buyAlert.addAction(buyAlertAction)
        present(buyAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userToken = userDefault.value(forKey: tokenKey) as! String
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCoinFunction()
    }


}
