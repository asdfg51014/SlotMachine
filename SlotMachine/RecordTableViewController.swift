//
//  RecordTableViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/17.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {

    var gameRecordPriceArray: [String] = []
    var gameRecordTimeArray: [String] = []
    
    let userDefault = UserDefaults.standard
    let gameRecordPriceArrayKey = "GameRecordPriceArray"
    let gameRecordTimeArrayKey = "GameRecordTimeArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameRecordPriceArray = userDefault.array(forKey: gameRecordPriceArrayKey) as? [String] ?? [String]()
        gameRecordTimeArray = userDefault.array(forKey: gameRecordTimeArrayKey) as? [String] ?? [String]()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameRecordPriceArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        cell.priceLabel.text = gameRecordPriceArray[indexPath.row]
        cell.timeLabel.text = gameRecordTimeArray[indexPath.row]
        
        return cell
    }

}
