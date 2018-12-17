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
    var userCoins = 0
    let userCoinsKey = "UserCoins"
    var appNotesCount = 0
    let appNotesCountKey = "AppNotesCount"
    var playGameNotesCount = 0
    let playGameNotesCountKey = "PlayGameNotesCount"
    
    @IBOutlet var appNotesLabel: UILabel!
    @IBOutlet var playGameNotesLabel: UILabel!
    @IBOutlet var userCoinsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appNotesCount = userDefault.integer(forKey: appNotesCountKey)
        appNotesCount += 1
        userDefault.set(appNotesCount, forKey: appNotesCountKey)
        appNotesLabel.text = "App共打開\(appNotesCount)次"
        playGameNotesLabel.text = "一共玩了\(userDefault.integer(forKey: playGameNotesCountKey))次遊戲"
        userCoinsLabel.text = "剩餘代幣： 💰\(String(userDefault.integer(forKey: userCoinsKey)))"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playGameNotesLabel.text = "一共玩了\(userDefault.integer(forKey: playGameNotesCountKey))次遊戲"
        userCoinsLabel.text = "剩餘代幣： 💰\(String(userDefault.integer(forKey: userCoinsKey)))"
        playGameNotesLabel.text = "一共玩了\(userDefault.integer(forKey: playGameNotesCountKey))次遊戲"
        print("Home Page")
    }
}
