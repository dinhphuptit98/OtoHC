//
//  LoginViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 02/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {
   
    let check = 0
    @IBOutlet weak var nameLogin: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBt: UIButton!
    @IBOutlet weak var registerBt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

       
    
    @IBAction func loginBt(_ sender: UIButton) {
        let urlString = "http://14.177.236.88:8089/api/Login?UserName=\(nameLogin.text!)&Password=\(MD5(password.text!))"
        
        Alamofire.request(urlString).responseJSON{ response in
            print(response)
            
            if let profileJSON = response.result.value{
                let profileObj:Dictionary = profileJSON as! Dictionary<String,Any>
                let status:Int = profileObj["status"] as! Int
                
                
                // dieu kien de dang nhap
                if self.check == status{
                    let alert = UIAlertController(title: nil, message: "Sai tên đăng nhập hoặc mật khẩu yêu cầu nhập lại hoặc đăng kí mới", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Đồng Ý", style: UIAlertActionStyle.cancel, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    
                    let value:Dictionary<String,Any> = profileObj["value"] as! Dictionary<String,Any>
                    let fullName:String = value["FullName"] as! String
                    let phone:String = value["PhoneNumber"] as! String
                    let adress:String = value["Address"] as! String
                    let id:Int = value["Id"] as! Int
                    let deviceToken:String = value["DeviceToken"] as! String
                    
                    UserDefaults.standard.set(fullName, forKey: "fullName")
                    UserDefaults.standard.set(phone, forKey: "phoneNumber")
                    UserDefaults.standard.set(adress, forKey: "adress")
                    UserDefaults.standard.set(id, forKey: "Id")
                    UserDefaults.standard.set(deviceToken, forKey: "DeviceToken")
                    let application = UIApplication.shared.delegate as! AppDelegate
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "Login") 
                    let navigationController = UINavigationController(rootViewController: rootViewController)
                    application.window?.rootViewController = navigationController
                    
                    
                }
            }
        }
    }
    
    
}
