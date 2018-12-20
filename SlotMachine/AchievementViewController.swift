//
//  AchievementViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {

    let firstWinGame = FirstWinGame()
    let lose10Games = Lose10Games()
    let userDefault = UserDefaults.standard
    var userToken = ""
    let tokenKey = "TokenKey"
    
    var winAll = ""
    var lose10 = ""
    
    let showAc = ShowAchievement()
    var myArray: [AchievementMedol] = []
    var acResponse: AchievementResponse?
    
    @IBOutlet var win2GamesImageView: UIImageView!
    @IBOutlet var play10TimesImageView: UIImageView!
    
    
    @IBOutlet var winTheGameImageView: UIImageView!
    @IBOutlet var lose10TimesImageView: UIImageView!
    
    
    func judgAchievement(){
        
        if acResponse?.allWin == 1 {
            winTheGameImageView.image = UIImage(named: "check")
        } else {
            winTheGameImageView.image = UIImage(named: "unCheck")
        }
        
        if acResponse?.loss10Time == 1 {
            lose10TimesImageView.image = UIImage(named: "check")
        } else {
            lose10TimesImageView.image = UIImage(named: "unCheck")
        }
        
        if acResponse?.play10Time == 1 {
            play10TimesImageView.image = UIImage(named: "check")
        } else {
            play10TimesImageView.image = UIImage(named: "unCheck")
        }
        
        if acResponse?.winTwice == 1 {
            win2GamesImageView.image = UIImage(named: "check")
        } else {
            win2GamesImageView.image = UIImage(named: "unCheck")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userToken = userDefault.value(forKey: tokenKey) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAc.showAchievement(userToken) { (get) in
            self.acResponse = get
            DispatchQueue.main.sync {
                self.judgAchievement()
            }
        }
    }


}
