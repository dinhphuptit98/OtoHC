    //
//  MAPViewController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 25/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
    
class MAPViewController: UIViewController ,CLLocationManagerDelegate{
    
    @IBOutlet weak var viewA: UIView!
    
    var count = Int()
    var arrLocations = [String]()
    var contacts: [Contact] = []
    var arrFirst = [String]()
    var arrSecond = [String]()
    var arrString : [String] = []
    var latitudeMe = Double()
    var longitudeMe = Double()
    
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        return locationManager
    }()
    
    var markerMe: GMSMarker!
    var markerFriends = [GMSMarker]()
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.mapType = .normal
        placesClient = GMSPlacesClient.shared()
        
        // get data API member
        DataSerVice.share.getDataContact {[unowned self] contacts in
            self.contacts = contacts
            for i in 0...contacts.count - 1{
                self.arrLocations.append(contacts[i].Location)
            }
            for i in self.arrLocations{
                if let string = (i.range(of: ",")?.lowerBound) {
                    let firstPlace = String(i.prefix(upTo: string))
                    self.arrFirst.append(firstPlace)
                }
                if let string = (i.range(of: ",")?.upperBound) {
                    let secondPlace = String(i.suffix(from: string))
                    self.arrSecond.append(secondPlace)
                }
            }
            self.count = self.arrFirst.count
            print(self.count)
        }
    }
    
    
    
    // add marker friend
    func addMarker(a : Double , b : Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: a, longitude: b)
        markerFriends.append(marker)
    }
    
    // xu ly vi tri
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation =  locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        latitudeMe = location.coordinate.latitude
        longitudeMe = location.coordinate.longitude
        //update vi tri cua ban len server
        let idMe = UserDefaults.standard.string(forKey: "Id")
        let deviceTokenMe = UserDefaults.standard.string(forKey: "DeviceToken") ?? "123"
        let urlString = "http://14.177.236.88:8089/api/MemberLocationHis/UpdateHistories?IdMember=\(idMe!)&Location=\(latitudeMe),\(longitudeMe)&DeviceToken=\(deviceTokenMe)"
        Alamofire.request(urlString).responseJSON{ response in
            print(response)
        }
        
        
        // danh dau vi tri
        mapView.clear()
        markerMe = GMSMarker()
        markerMe.position = location.coordinate
        markerMe.map = mapView
        markerMe.title = "Vi tri cua toi"
        
        //vi tri cua ban be
        for i in 0..<count {
            addMarker(a: arrFirst[i].toDouble()!, b: arrSecond[i].toDouble()!)
            markerFriends[i].map = mapView
            markerFriends[i].icon = #imageLiteral(resourceName: "Image-4")
            markerFriends[i].title = contacts[i].FullName
            markerFriends[i].snippet = contacts[i].PhoneNumber
        }

        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // xu ly dieu kien xac dinh vi tri day
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch  status {
        case .restricted:
            print("Location access was restricted")
        case .denied :
            print("User denied access to location")
            // hienn thi vi tri mac dinh
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // xu ly bi loi
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error:\(error)")
    }
}




