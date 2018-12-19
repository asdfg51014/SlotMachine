//
//  AchievementModel.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/19.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation

struct AchievementMedol: Codable {
    let result: String
    let response: AchievementResponse
}

struct AchievementResponse: Codable {
    let allWin: Int
    let loss10Time: Int
    let winTwice: Int
    let play10Time: Int
}
