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
    @IBOutlet weak var logout: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoSelf.layer.cornerRadius = photoSelf.frame.size.width/2
        photoSelf.layer.masksToBounds = true
        
        nameSelf.text = UserDefaults.standard.string(forKey: "fullName")!
        adressSelf.text = UserDefaults.standard.string(forKey: "adress")!
        numberPhoneSelf.text = UserDefaults.standard.string(forKey: "phoneNumber")!
    }
    
    
    @IBAction func logoutBt(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Bạn có muốn đăng xuất không?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Có", style: UIAlertActionStyle.default, handler: { _ in
            let application = UIApplication.shared.delegate as! AppDelegate
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "LogOut") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: rootViewController)
            application.window?.rootViewController = navigationController
            
        }))
        alert.addAction(UIAlertAction(title: "Không", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
