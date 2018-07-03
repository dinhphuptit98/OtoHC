//
//  SOSViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 27/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import DLLocalNotifications
class SOSViewController: UIViewController {

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

    @IBAction func sosButton(_ sender: UIButton) {
    
        let alert = UIAlertController(title: nil, message: "Bạn có chắc chắn bật cứu hộ không?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Có", style: UIAlertActionStyle.default, handler: { _ in
            let triggerDate = Date().addingTimeInterval(5)
            let firstNotification = DLNotification(identifier: "firstNotification", alertTitle: "WARINNG , HELP ME", alertBody: "Tôi gặp nguy hiểm mọi người đến giúp tôi", date: triggerDate, repeats: .None)
            
            let scheduler = DLNotificationScheduler()
            scheduler.scheduleNotification(notification: firstNotification)

            
        }))
        alert.addAction(UIAlertAction(title: "Không", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
