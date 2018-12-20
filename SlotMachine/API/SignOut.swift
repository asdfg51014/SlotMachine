//
//  SignOut.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import SwiftyJSON

class SignOutAPI {
    
    let userDefault = UserDefaults.standard
    let tokenKey = "TokenKey"
    var result = ""
    var response = ""
    
    func signOut(_ token: String, call: @escaping (String) -> Void){
        
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/logout")
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
                    if let response = response as? HTTPURLResponse {}
                    let responseString = String(data: data, encoding: .utf8)
                    print("SignOut responseString: \(responseString)")
                    
                    if let json: JSON = try? JSON(data: data){
                        self.result = json["result"].string ?? ""
                        self.response = json["response"].string ?? ""
                        
                        call(self.result)
                    }
                    }.resume()
            } catch {
            }
        }
        
        
    }
}
