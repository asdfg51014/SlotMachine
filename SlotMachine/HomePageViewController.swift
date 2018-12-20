//
//  HomePageViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/17.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    let userDefault = UserDefaults.standard
    var userCoins = ""
//    let userCoinsKey = "UserCoins"
    var appNotesCount = 0
    let appNotesCountKey = "AppNotesCount"
    var playGameNotesCount = 0
    let playGameNotesCountKey = "PlayGameNotesCount"
    var depositBool = false
    let depositKey = "DepositKey"
    let coinsChange = CoinsChange()
    let signOutAPI = SignOutAPI()
    let showCoins = ShowCoins()
    let tokenKey = "TokenKey"
    var userToken = ""
    var result = ""
    
    let showRecord = ShowRecord()
    var recordArray: [RecordModel] = []
    
    
    @IBOutlet var appNotesLabel: UILabel!
    @IBOutlet var playGameNotesLabel: UILabel!
    @IBOutlet var userCoinsLabel: UILabel!
    
    @IBAction func logoutItemButton(_ sender: UIBarButtonItem){
        self.userToken = userDefault.string(forKey: tokenKey)!
        signOutAPI.signOut(userToken) { (logoutResult) in
            self.result = logoutResult
            print(self.result)
            if self.result == "true" {
                self.logoutSccess()
            }
        }
    }
    
    func showCoinsFunction(){
        self.showCoins.showCoins(self.userToken) { (coins) in
            self.userCoins = coins
            
            DispatchQueue.main.async {
                print(self.userCoins)
                self.userCoinsLabel.text = "剩餘代幣： 💰\(self.userCoins)"
            }
        }
    }
    
    func logoutSccess(){
        let logoutAlert = UIAlertController(title: "登出成功", message: "按下OK登出", preferredStyle: .alert)
        let logoutAlertAction = UIAlertAction(title: "OK", style: .default) { (logout) in
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        logoutAlert.addAction(logoutAlertAction)
        present(logoutAlert, animated: true, completion: nil)
    }
    
    func appNotesFunction(){
        appNotesCount = userDefault.integer(forKey: appNotesCountKey)
        appNotesCount += 1
        userDefault.set(appNotesCount, forKey: appNotesCountKey)
        appNotesLabel.text = "App共打開 \(appNotesCount) 次"
    }
    
    func playGameCountFunction(){
        var playGameCount = userDefault.array(forKey: "GameRecordPriceArray")?.count
        if playGameCount == nil {
            playGameNotesLabel.text = "一共玩了0次遊戲"
        } else {
            playGameNotesLabel.text = "一共玩了 \(playGameCount!) 次遊戲"
        }
        print(userDefault.array(forKey: "GameRecordPriceArray")?.count)
    }
    
    func depositValueFunction(){
        depositValueAlert()
    }
    
    func depositValueAlert(){
        depositBool = false
        depositBool = userDefault.bool(forKey: depositKey)
        if depositBool == false {
            let firstAlert = UIAlertController(title: "歡迎來到Slot Machine", message: "恭喜獲得500代幣", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (depositCoins) in
                self.depositBool = true
                self.userDefault.set(self.depositBool, forKey: self.depositKey)

                self.coinsChange.addCoin("500", self.tokenKey, "First Game", call: { (coins) in
                    self.userCoinsLabel.text = String(self.userCoins)
                })
            }
            firstAlert.addAction(alertAction)
            present(firstAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("afullafsvhlsivuh")
        userToken = userDefault.value(forKey: tokenKey) as! String
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userCoinsLabel.text = "Loading..."
        showCoinsFunction()
        appNotesFunction()
        playGameCountFunction()
    }
}
