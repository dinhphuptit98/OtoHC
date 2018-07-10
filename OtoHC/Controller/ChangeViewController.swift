//
//  ChangeViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 09/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import Alamofire
class ChangeViewController: UIViewController {

    @IBOutlet weak var passOld: UITextField!
    @IBOutlet weak var passNew: UITextField!
    @IBOutlet weak var passNewAgain: UITextField!
    @IBOutlet weak var saveBt: UIButton!
    @IBOutlet weak var erLabel1: UILabel!
    @IBOutlet weak var erLabel2: UILabel!
    @IBOutlet weak var erLabel3: UILabel!
    
    var checkPass = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButton(_ sender: UIButton) {
        if passOld.text != UserDefaults.standard.string(forKey: "pass") {
            erLabel1.isHidden = false
        }
        if passNew.text == passOld.text {
            erLabel2.isHidden = false
        }
        else if passNewAgain.text != passNew.text {
            erLabel3.isHidden = false
        }
        else{
            erLabel1.isHidden = true
            erLabel2.isHidden = true
            erLabel3.isHidden = true		
            
            let id = UserDefaults.standard.string(forKey: "Id")!
            let userName = UserDefaults.standard.string(forKey: "UserName")
            
//            let urlString = "http://192.168.1.212:8089/api/Members/UpdateMember?Id=\(id)&ShortName=&FullName=&PhoneNumber=&LicencePlate=&LocationId=&Address=&Note=&UserName=\(userName!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&Password=\(MD5(passNew.text!).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
//            Alamofire.request(urlString).responseJSON{ response in
//                print(response)
//            }
        }
    }
}

