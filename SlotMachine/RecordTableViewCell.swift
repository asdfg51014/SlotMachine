//
//  RecordTableViewCell.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/17.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var bankroolLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
