//
//  DataSerVice.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 25/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
typealias DICT = Dictionary<AnyHashable,Any>
class DataSerVice {
    static let share : DataSerVice = DataSerVice()
    private var _arrayLocation : [String]?
    var arrayLocation : [String]{
        set{
            _arrayLocation = newValue
        }get{
            return _arrayLocation ?? []
        }
    }
    func getDataContact(complete: @escaping ([Contact])->Void) {
        var contacts: [Contact] = []
        let urlString = "http://14.177.236.88:8089/api/Members/GetMember"
        let url = URL(string : urlString)!
        
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else { return}
                
                do {
                    guard let result = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT else { return }
                    guard let contactsObj = result["value"] as? [DICT] else { return }
                    for contactObj in contactsObj {
                        if let contact = Contact(dict: contactObj) {
                            contacts.append(contact)
                        }
                    }
                    DispatchQueue.main.async {
                        complete(contacts)
                    }
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
}
