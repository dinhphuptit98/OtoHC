//
//  Profile.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 26/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit


class Profile {
    var Id : Int
    var FullName : String
    var PhoneNumber : String
    var Address : String
    var Location : String
    var DeviceToken : String
    
    init?(dict : DICT){
        guard let Id = dict["Id"] as? Int else { return nil }
        guard let FullName = dict["FullName"] as? String else { return nil }
        guard let PhoneNumber = dict["PhoneNumber"] as? String else { return nil }
        guard let Address = dict["Address"] as? String else { return nil }
        guard let Location = dict["Location"] as? String else { return nil }
        guard let DeviceToken = dict["DeviceToken"] as? String else { return nil }
        
        self.Id = Id
        self.FullName = FullName
        self.PhoneNumber = PhoneNumber
        self.Address = Address
        self.Location = Location
        self.DeviceToken = DeviceToken
    }
}
