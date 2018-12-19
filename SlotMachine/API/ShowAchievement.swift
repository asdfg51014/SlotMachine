//
//  ShowAchievement.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/19.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import SwiftyJSON

class ShowAchievement {
    
    var achievementArray: [AchievementMedol] = []
    var achievementResponse: [AchievementResponse] = []
    
    func showAchievement(_ token: String, call: @escaping (AchievementResponse) -> Void){
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/showachievement")
            var request = try! URLRequest(url: url!, method: .post, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            let body = [
                "api_token": token
            ]
            if (!JSONSerialization.isValidJSONObject(body)) {
                print("Isn't a valid JSON object")
                return
            }
            do {
                let json = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
                request.httpBody = json
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription)
                        print("Net Work Error")
                        return
                    }
                    let response = response
                    if let response = response as? HTTPURLResponse {}
                    let responseString = String(data: data, encoding: .utf8)
                  
                    
                    print("!@#$%^&*(")
                    print("signIn responseString: \(responseString)")
                    let decoder = JSONDecoder()
                    let achievementData = try? decoder.decode(AchievementMedol.self, from: data)
                    print("____________")
                    let a = achievementData?.response
                    print(achievementData?.response.allWin)
                    
                    
//                    let json: JSON = try! JSON(data: data)
//                    print("------------")
//                    if let result = json[]["response"].array {
//                        print(result["winAll"])
//                    }
//
//                    print(json["result"].string)

                    
                    call(a!)
                    
                    
                    
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

