//
//  ViewProfileController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 26/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import Alamofire
class ViewProfileController: UIViewController {

    @IBOutlet weak var photoSelf: UIImageView!
    @IBOutlet weak var nameSelf: UITextField!
    @IBOutlet weak var numberPhoneSelf: UITextField!
    @IBOutlet weak var adressSelf: UITextField!
    @IBOutlet weak var shortName: UITextField!
    @IBOutlet weak var idSelf: UITextField!
    @IBOutlet weak var editBt: UIButton!
    @IBOutlet weak var saveBt: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoSelf.layer.cornerRadius = photoSelf.frame.size.width/2
        photoSelf.layer.masksToBounds = true
        editBt.layer.cornerRadius = editBt.frame.size.width/2
        editBt.layer.masksToBounds = true
        saveBt.layer.cornerRadius = saveBt.frame.size.width/2
        saveBt.layer.masksToBounds = true
        
        
        nameSelf.text = UserDefaults.standard.string(forKey: "fullName")!
        adressSelf.text = UserDefaults.standard.string(forKey: "adress")!
        numberPhoneSelf.text = UserDefaults.standard.string(forKey: "phoneNumber")!
        idSelf.text = "ID : \(UserDefaults.standard.string(forKey: "Id")!)"
        shortName.text = UserDefaults.standard.string(forKey: "shortName")
    }
    

    
    @IBAction func edit(_ sender: UIButton) {
        nameSelf.isEnabled = true
        numberPhoneSelf.isEnabled = true
        adressSelf.isEnabled = true
        shortName.isEnabled = true
    }
    
    @IBAction func save(_ sender: UIButton) {
        nameSelf.isEnabled = false
        numberPhoneSelf.isEnabled = false
        adressSelf.isEnabled = false
        shortName.isEnabled = false
      
        let id = UserDefaults.standard.string(forKey: "Id")!
        
        let urlString = "http://192.168.1.212:8089/api/Members/UpdateMember?Id=\(id)&ShortName=\(shortName.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&FullName=\(nameSelf.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&PhoneNumber=\(numberPhoneSelf.text!)&LicencePlate=&LocationId=&Address=\(adressSelf.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&Note=&UserName=&Password="
        Alamofire.request(urlString).responseJSON{ response in
            print(response)
        }
    }
    
}
