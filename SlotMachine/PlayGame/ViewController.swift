
import UIKit
import CoreMotion

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let coinsChange = CoinsChange()
    let showCoins = ShowCoins()
    let firstWG = FirstWinGame()
    let loseGC = Lose10Games()
    var userToken = ""
    let emojiCount = 120000
    let userDefault = UserDefaults.standard
    var userCoins = ""
    let userCoinsKey = "UserCoins"
    let userTokenKey = "TokenKey"
    let firstWinGamekey = "FWGK"
    var firstWinGameBool = false
    var loseCount = 0
    let lose10GamesKey = "LoseKey"
    
    
    let playGameNotesCountKey = "PlayGameCountKey"
    var playGameNotesCount = 0
    let gameRecordPriceArrayKey = "GameRecordPriceArray"
    let gameRecordTimeArrayKey = "GameRecordTimeArray"
    var loseGameCount = 0
    
    
    
    
    var gameRecordPriceArray: [String] = []
    var gameRecordTimeArray: [String] = []
    var optionEmoji = [String]()
    var dataArrayA = [Int]()
    var dataArrayB = [Int]()
    var dataArrayC = [Int]()
    
    var timerA: Timer?
    var timerB: Timer?
    var timerC: Timer?
    
    @IBOutlet var resetButton: UIBarButtonItem!
    @IBOutlet var coinsLabel: UILabel!
    @IBOutlet var keyASwitch: UISwitch!
    @IBOutlet var keyBSwitch: UISwitch!
    @IBOutlet var keyCSwitch: UISwitch!
    @IBOutlet var emojiPickerView: UIPickerView!

    @IBAction func reset(_ sender: UIBarButtonItem) {
        resetGame()
    }
    
    @IBAction func stopSwitchA(_ sender: UISwitch){
        if keyASwitch.isOn {
            if timerA != nil {
                timerA?.invalidate()
                keyASwitch.isEnabled = false
            }
            judgSwitchs()
        } 
    }
    
    @IBAction func stopSwitchB(_ sender: UISwitch){
        if keyBSwitch.isOn {
            if timerB != nil {
                timerB?.invalidate()
                keyBSwitch.isEnabled = false
            }
            judgSwitchs()
        }
    }
    
    @IBAction func stopSwitchC(_ sender: UISwitch){
        if keyCSwitch.isOn {
            if timerC != nil {
                timerC?.invalidate()
                keyCSwitch.isEnabled = false
            }
            judgSwitchs()
        }
    }
    
    //MARK: start to turn
    @objc func startToTurnPickerViewA(){
        emojiPickerView.selectRow(Int(arc4random() % 94 + 3), inComponent: 0, animated: true)
    }
    
    @objc func startToTurnPickerViewB(){
        emojiPickerView.selectRow(Int(arc4random() % 94 + 3), inComponent: 1, animated: true)
    }
    
    @objc func startToTurnPickerViewC(){
        emojiPickerView.selectRow(Int(arc4random() % 94 + 3), inComponent: 2, animated: true)
    }
    
    func showCoin(){
        showCoins.showCoins(userToken) { (userCoins) in
            self.userCoins = userCoins
            DispatchQueue.main.sync {
                self.coinsLabel.text = String(self.userCoins)
            }
        }
    }
    
    func resetGame(){
        keyASwitch.isOn = false
        keyASwitch.isEnabled = false
        keyBSwitch.isOn = false
        keyBSwitch.isEnabled = false
        keyCSwitch.isOn = false
        keyCSwitch.isEnabled = false
        resetButton.isEnabled = false
    }
    
    func startGame(){
        keyASwitch.isEnabled = true
        keyBSwitch.isEnabled = true
        keyCSwitch.isEnabled = true
        
    }
    
    func judgPlay10Game(){
        loseCount = userDefault.integer(forKey: lose10GamesKey)
        print(loseCount)
        if loseCount < 9 {
            loseCount += 1
        } else if loseCount == 9 {
            loseCount += 1
            loseGC.lose10Game("loss10Time", self.userToken, true, call: { (lose) in
            })
        }
        userDefault.set(loseCount, forKey: lose10GamesKey)
    }
    
    func judgSwitchs(){
        if keyASwitch.isOn == true && keyBSwitch.isOn == true && keyCSwitch.isOn == true {
            let emojiPickerViewAComponent = dataArrayA[emojiPickerView.selectedRow(inComponent: 0)]
            let emojiPickerViewBComponent = dataArrayB[emojiPickerView.selectedRow(inComponent: 1)]
            let emojiPickerViewCComponent = dataArrayC[emojiPickerView.selectedRow(inComponent: 2)]
            if (emojiPickerViewAComponent == emojiPickerViewBComponent && emojiPickerViewBComponent == emojiPickerViewCComponent) {
                print("BINGO")
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    self.winTheGame()
                }
            } else if emojiPickerViewAComponent == emojiPickerViewBComponent || emojiPickerViewBComponent == emojiPickerViewCComponent || emojiPickerViewAComponent == emojiPickerViewCComponent {
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    self.winHalfGame()
                }
            } else {
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    self.loseTheGame()
                }
                print("YOU LOSE")
            }
        }
    }
    
    
    
    func playAGame(){
        coinsChange.minusCoin("10", userToken, "Play Game") { (coins) in
            self.showCoin()
        }
    }
    
    func winTheGame(){
        let winAlert = UIAlertController(title: "YOU WIN!!", message: "恭喜獲得1000金幣", preferredStyle: .alert)
        let winAlertAction = UIAlertAction(title: "獲取金幣", style: .default) { (winCoins) in
            self.resetGame()
            self.coinsChange.addCoin("1000", self.userToken, "Win The Game", call: { (coins) in
                self.showCoin()
            })
            self.firstWinGameBool = self.userDefault.bool(forKey: self.firstWinGamekey)
            if self.firstWinGameBool != true {
                self.firstWinGameBool = true
                self.firstWG.winGame("allWin", self.userToken, true, call: { (win) in
                })
                self.userDefault.set(self.firstWinGameBool, forKey: self.firstWinGamekey)
            }
        }
        winAlert.addAction(winAlertAction)
        present(winAlert, animated: true, completion: nil)
    }
    
    func winHalfGame(){
        let winHalfAlert = UIAlertController(title: "差一點！", message: "獲得50金幣", preferredStyle: .alert)
        let winHalfAction = UIAlertAction(title: "獲取金幣", style: .default) { (winHalfCoins) in
            self.resetGame()
            self.coinsChange.addCoin("50", self.userToken, "Win The Half Game", call: { (coins) in
                self.showCoin()
            })
        }
        winHalfAlert.addAction(winHalfAction)
        present(winHalfAlert, animated: true, completion: nil)
    }
    
    func loseTheGame(){
        judgPlay10Game()
        if userCoins == "250" {
            let resetAlert = UIAlertController(title: "送禮來囉!!", message: "再給你100!", preferredStyle: .alert)
            let resetAlertAction = UIAlertAction(title: "OK", style: .default) { (resetUserCoins) in
                self.resetGame()
                
                self.coinsChange.addCoin("100", self.userToken, "Gift", call: { (coins) in
                    
                    self.showCoin()
                })
            }
            resetAlert.addAction(resetAlertAction)
            present(resetAlert, animated: true, completion: nil)
        } else {
            let loseAlert = UIAlertController(title: "YOU LOSE!", message: "再來一次吧！", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "再玩一次", style: .default) { (resetTheGame) in
                self.resetGame()
            }
            
            loseAlert.addAction(okAlertAction)
            present(loseAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: Set PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiCount
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let fullSize = UIScreen.main.bounds
        let pickerWidth = fullSize.width - 80
        
        return pickerWidth / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let emojiLabel = UILabel()
        switch component {
        case 0:
            emojiLabel.text = optionEmoji[(Int)(dataArrayA[row])]
        case 1:
            emojiLabel.text = optionEmoji[(Int)(dataArrayB[row])]
        case 2:
            emojiLabel.text = optionEmoji[(Int)(dataArrayC[row])]
        default:
            break
        }
        emojiLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        emojiLabel.textAlignment = NSTextAlignment.center

        return emojiLabel
    }
    
    //MARK: Accelerometer
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            timerA = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(startToTurnPickerViewA), userInfo: nil, repeats: true)
            timerB = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(startToTurnPickerViewB), userInfo: nil, repeats: true)
            timerC = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(startToTurnPickerViewC), userInfo: nil, repeats: true)
            startGame()
            playAGame()
            resetButton.isEnabled = true
            
            gameRecordPriceArray = userDefault.array(forKey: gameRecordPriceArrayKey) as? [String] ?? [String]()
            gameRecordTimeArray = userDefault.array(forKey: gameRecordTimeArrayKey) as? [String] ?? [String]()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionEmoji = ["😀", "👻", "👺", "🌎", "⛄️", "🍔", "🏀", "🏸", "🚗", "📱"]
        for i in stride(from: 0, to: emojiCount + 1, by: 1) {
            dataArrayA.append((Int)(arc4random() % 10))
            dataArrayB.append((Int)(arc4random() % 10))
            dataArrayC.append((Int)(arc4random() % 10))
        }
        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        resetGame()
        coinsLabel.text = "Loding..."
        userToken = userDefault.value(forKey: userTokenKey) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCoin()
    }
}

