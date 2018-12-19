//
//  SignIn.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SignInAPI {
    
    public var name = ""
    public var coin = 0
    public var result = ""
    public var token = ""
    let userDefault = UserDefaults.standard
    let tokenKey = "TokenKey"
    
    
    func signIn(_ email: String, _ password: String, call: @escaping (String) -> Void){
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/login")
            var request = try! URLRequest(url: url!, method: .post, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            let body = [
                "email": email,
                "password": password
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
//                    print("!@#$%^&*(")
//                    print("signIn responseString: \(responseString)")
//                    print("------")
                    if let json: JSON = try? JSON(data: data){
//                        print(json)
                        self.coin = json["response"]["coin"].int ?? 0
                        self.name = json["response"]["name"].string ?? ""
                        self.result = json["result"].string ?? ""
                        self.token = json["response"]["api_token"].string ?? ""
                        self.userDefault.set(self.token, forKey: self.tokenKey)
                        print(self.token)
                        call(self.result)
                    }
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
