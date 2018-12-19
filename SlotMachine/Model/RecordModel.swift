//
//  RecordModel.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation

struct RecordModel: Decodable {

    let result: String
    let response: [[ResponseArray]]
    
}

struct ResponseArray: Decodable {
    let id: Int
    let user_id: String
    let bankroll: String
    let type: String
    let created_at: String
    let updated_at: String
}
