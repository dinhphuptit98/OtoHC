//
//  ContactViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 25/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI

class ContactViewController: UIViewController , MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var viewContact: UIView!
    @IBOutlet weak var dieuhuongButton: UIButton!
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var imageMember: UIImageView!
    @IBOutlet weak var nameMember: UILabel!
    @IBOutlet weak var numberphoneMember: UILabel!
   
    var contact : Contact?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameMember.text = contact?.FullName
        numberphoneMember.text = contact?.PhoneNumber
        
        
        
        imageMember.layer.cornerRadius = imageMember.frame.size.width/2
        imageMember.layer.masksToBounds = true
        smsButton.layer.cornerRadius = smsButton.frame.size.width/2
        smsButton.layer.masksToBounds = true
        callButton.layer.cornerRadius = callButton.frame.size.width/2
        callButton.layer.masksToBounds = true
        
        dieuhuongButton.layer.cornerRadius = 100
         viewContact.layer.cornerRadius = 150
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    @IBAction func callBt(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "tel://\(numberphoneMember.text!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        if let url = NSURL(string : "TEL://" + numberphoneMember.text!){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        print("call to \(numberphoneMember.text!)")
        
    }
    
    @IBAction func SMSbt(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = "hello"
            controller.recipients = ["\(numberphoneMember.text ?? "")"]
            controller.messageComposeDelegate = self
            self.present(controller,animated: true,completion: nil)
        }else {
            print("Sending Message to \(numberphoneMember.text!)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ViewNavigationController
        vc?.location2 = contact!.Location
    }
    
}
