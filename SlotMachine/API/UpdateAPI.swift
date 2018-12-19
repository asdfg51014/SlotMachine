//
//  UpdateAPI.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/19.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import SwiftyJSON

class UpdateAPI {
    
    let userDefault = UserDefaults.standard
    var result = ""
    var userToken = ""
    let tokenKey = "TokenKey"
    
    func signIn(_ name: String, _ token: String, call: @escaping (String) -> Void){
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/update")
            var request = try! URLRequest(url: url!, method: .post, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            let body = [
                "name": name,
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
                    if let response = response as? HTTPURLResponse {}
                    let responseString = String(data: data, encoding: .utf8)
                    print("response: \(responseString)")
                    print("response: \(responseString)")
                    if let json: JSON = try? JSON(data: data){
                        self.result = json["result"].string ?? ""
                        self.userToken = json["response"]["api_token"].string ?? ""
                        self.userDefault.set(self.userToken, forKey: self.tokenKey)
                        
                        
                        call(self.result)
                    }
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
}
