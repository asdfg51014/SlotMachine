//
//  RecordTableViewController.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/17.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordTableViewController: UITableViewController {

    let userDefault = UserDefaults.standard
    let tokenKey = "TokenKey"
    var userToken = ""
    let showRecord = ShowRecord()
    var recordArray: [[ResponseArray]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userToken = userDefault.value(forKey: tokenKey) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showRecord.showRecord(userToken) { (record) in
            self.recordArray = record
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        
        cell.bankroolLabel.text = recordArray[indexPath.row][0].bankroll
        cell.typeLabel.text = recordArray[indexPath.row][0].type
        cell.timeLabel.text = recordArray[indexPath.row][0].created_at
        
        
        
        return cell
    }

}
