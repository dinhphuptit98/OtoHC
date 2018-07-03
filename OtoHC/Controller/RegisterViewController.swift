//
//  RegisterViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 02/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var shortname: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var adress: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let check = 0 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerBt(_ sender: UIButton) {
        let urlString = "http://192.168.1.212:8089/api/Members/InsertMember?ShortName=\(shortname.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&FullName=\(fullname.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&PhoneNumber=\(phonenumber.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&LicencePlate=&LocationId=&Address=\(adress.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&Note=&UserName=\(username.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&Password=\(MD5(password.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!))"

        
        Alamofire.request(urlString).responseJSON{ response in
            print(response)
            if let profileJSON = response.result.value{
                let profileObj:Dictionary = profileJSON as! Dictionary<String,Any>
                let status:Int = profileObj["status"] as! Int
                if self.check == status {
                    let alert = UIAlertController(title: nil, message: "Đăng kí chưa hợp lệ , đăng kí lại", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Đồng Ý", style: UIAlertActionStyle.cancel, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: nil, message: "Đăng kí thành công , đăng nhập để sử dụng", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Đồng Ý", style: UIAlertActionStyle.cancel, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
