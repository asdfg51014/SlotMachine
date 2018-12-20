//
//  CoinsChange.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import SwiftyJSON

class CoinsChange {
    
    let userDefault = UserDefaults.standard
    
    let userCoinsKey = "UserCoinsKey"
    let reasonKey = "ReasonKey"
    let userToken = "TokenKey"
    var result = ""
    var userCoin = ""
    
    
    func addCoin(_ get: String, _ token: String, _ type: String, call: @escaping (String) -> Void){
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/addcoin")
            var request = try! URLRequest(url: url!, method: .post, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            let body = [
                "profit": get,
                "api_token": token,
                "type": type,
                "game": "Albert"
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
                    if let response = response as? HTTPURLResponse {}
                    let responseString = String(data: data, encoding: .utf8)
                    print("AddConin responseString: \(responseString)")
                    if let json: JSON = try? JSON(data: data){
                        self.result = json["result"].string ?? ""
                        self.userCoin = json["coin"].string ?? ""
                        call(self.userCoin)
                    }
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func minusCoin(_ cost: String, _ token: String, _ type: String, call: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/minuscoin")
            var request = try! URLRequest(url: url!, method: .post, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            let body = [
                "loss": cost,
                "api_token": token,
                "type": type,
                "game": "Albert"
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
                    if let response = response as? HTTPURLResponse {}
                    let responseString = String(data: data, encoding: .utf8)
                    print("MinusCoins responseString: \(responseString)")
                    if let json: JSON = try? JSON(data: data){
                        self.result = json["result"].string ?? ""
                        self.userCoin = json["coin"].string ?? ""
                        call(self.userCoin)
                    }
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
