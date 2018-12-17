
import UIKit
import CoreMotion

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let emojiCount = 120000
    let userDefault = UserDefaults.standard
    var userCoins = 0
    let userCoinsKey = "UserCoins"
    var depositBool = false
    let depositKey = "DepositKey"
    var playGameNotesCount = 0
    let gameRecordPriceArrayKey = "GameRecordPriceArray"
    let gameRecordTimeArrayKey = "GameRecordTimeArray"
    
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
    
    func getUserCoins(_ coins: Int){
        self.userCoins = self.userDefault.integer(forKey: self.userCoinsKey)
        self.userCoins += coins
        self.userDefault.set(self.userCoins, forKey: self.userCoinsKey)
        self.coinsLabel.text = String(self.userCoins)
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
        userCoins -= 10
        coinsLabel.text = String(userCoins)
        userDefault.set(userCoins, forKey: userCoinsKey)
    }
    
    func winTheGame(){
        let winAlert = UIAlertController(title: "YOU WIN!!", message: "恭喜獲得1000金幣", preferredStyle: .alert)
        let winAlertAction = UIAlertAction(title: "獲取金幣", style: .default) { (winCoins) in
            self.getUserCoins(1000)
        }
        winAlert.addAction(winAlertAction)
        present(winAlert, animated: true, completion: nil)
    }
    
    func winHalfGame(){
        let winHalfAlert = UIAlertController(title: "差一點！", message: "獲得50金幣", preferredStyle: .alert)
        let winHalfAction = UIAlertAction(title: "獲取金幣", style: .default) { (winHalfCoins) in
            self.getUserCoins(50)
        }
        winHalfAlert.addAction(winHalfAction)
        present(winHalfAlert, animated: true, completion: nil)
    }
    
    func loseTheGame(){
        
        if userCoins == 0 {
            let resetAlert = UIAlertController(title: "YOU LOSE!", message: "您已破產，請投胎重新做人 \n記錄將不會刪除", preferredStyle: .alert)
            let resetAlertAction = UIAlertAction(title: "OK", style: .default) { (resetUserCoins) in
                self.getUserCoins(500)
            }
        } else {
            let loseAlert = UIAlertController(title: "YOU LOSE!", message: "再來一次吧！", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "再玩一次", style: .default) { (resetTheGame) in
                self.resetGame()
            }
            loseAlert.addAction(okAlertAction)
            present(loseAlert, animated: true, completion: nil)
        }
    }
    
    func depositValueAlert(){
        if depositBool == false {
            let firstAlert = UIAlertController(title: "歡迎來到Slot Machine", message: "恭喜獲得500代幣", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (depositCoins) in
                self.depositBool = true
                self.userDefault.set(self.depositBool, forKey: self.depositKey)
                self.userCoins = 500
                self.userDefault.set(self.userCoins, forKey: self.userCoinsKey)
                self.coinsLabel.text = String(self.userCoins)
            }
            firstAlert.addAction(alertAction)
            present(firstAlert, animated: true, completion: nil)
        }
        coinsLabel.text = String(userCoins)
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
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日hh點mm分"
            let time = formatter.string(from: Date())
            gameRecordPriceArray.append("$10")
            gameRecordTimeArray.append(time)
            userDefault.set(gameRecordPriceArray, forKey: gameRecordPriceArrayKey)
            userDefault.set(gameRecordTimeArray, forKey: gameRecordTimeArrayKey)
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
        depositBool = false
        depositBool = userDefault.bool(forKey: depositKey)
        userCoins = userDefault.integer(forKey: userCoinsKey)
        depositValueAlert()
        coinsLabel.text = String(userCoins)
    }
}

