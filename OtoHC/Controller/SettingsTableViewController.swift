//
//  SettingsTableViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 06/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    var arrString = ["Kiểu Bản Đồ","Marker","Âm Thanh","Ngôn Ngữ","Điều Khoản","Thông Tin","Thông Tin Đăng Nhập","Đăng Xuất"]
    var arrImage = ["google","location","alarm","language","file","information","locked","exit"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrString.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
        cell.labelSet.text = arrString[indexPath.row]
        cell.photoSet.image = UIImage(named: arrImage[indexPath.row])
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 7:
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
            navigationController?.popToRootViewController(animated: false)
        case 6:
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let changeVC = storyboard.instantiateViewController(withIdentifier: "changeView") as! ChangeViewController
            self.navigationController?.pushViewController(changeVC, animated: true)
        default:
            print("no acion")
        }
    }


   
    
  

}
