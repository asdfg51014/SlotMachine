//
//  ShowRecord.swift
//  SlotMachine
//
//  Created by Albert on 2018/12/18.
//  Copyright © 2018 Albert.C. All rights reserved.
//

import Foundation
import SwiftyJSON

class ShowRecord {

    var recordArray: [RecordModel] = []
    var recorda: [[ResponseArray]] = []
    var result = ""
    
    func showRecord(_ token: String, call: @escaping ([[ResponseArray]]) -> Void){
        DispatchQueue.main.async {
            let url = URL(string: "http://192.168.55.226:8989/api/showrecord/1")
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
                    print("ShowRecord responseString: \(responseString)")
                   let decoder = JSONDecoder()
                    if let recordData = try? decoder.decode(RecordModel.self, from: data) {
                        self.recordArray = [recordData]
                        for i in self.recordArray[0].response {
                            print(i)
                            self.recorda.append(i)
                        }
                    }
                    call(self.recorda)
                    }.resume()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
