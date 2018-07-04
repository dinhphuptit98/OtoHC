//
//  ViewNavigationController.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 27/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
class ViewNavigationController: UIViewController ,CLLocationManagerDelegate{
    
    var location2 = ""
    var x : String = ""
    var y : String = ""
    var distanceAB = ""
    var time = ""
    var arrLocations = [String]()
    @IBOutlet weak var distanceLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    
    
    
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
    var markerFriend = GMSMarker()
    
    var currentLocation: CLLocation?
    @IBOutlet weak var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.mapType =  .terrain
        placesClient = GMSPlacesClient.shared()
        
        if let string = (location2.range(of: ",")?.lowerBound) {
            let firstPlace = String(location2.prefix(upTo: string))
            x = firstPlace
        }
        if let string = (location2.range(of: ",")?.upperBound) {
            let secondPlace = String(location2.suffix(from: string))
            y = secondPlace
        }
    }
    
    // vi tri hien tai va hien thi polyline den diem den
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation =  locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10.0)
        
        // danh dau vi tri cua ban
        mapView.clear()
        markerMe = GMSMarker()
        markerMe.position = location.coordinate
        markerMe.title = "Vi tri cua toi"
        markerMe.map = mapView
        
        markerFriend.position = CLLocationCoordinate2D(latitude: x.toDouble()!, longitude: y.toDouble()!)
        markerFriend.map = mapView
        markerFriend.icon = #imageLiteral(resourceName: "automobile (1)")
        
        
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
            
        } else {
            mapView.animate(to: camera)
        }
        
        //xu ly API polyline tu vi tri hien tai den diem den
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(location.coordinate.latitude),\(location.coordinate.longitude)&destination=\(x.toDouble()!),\(y.toDouble()!)&sensor=false&mode=driving")!
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: { (data, reponse, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let objectData = data else {return}
            do{
                guard let reuslts = try JSONSerialization.jsonObject(with: objectData, options: .mutableContainers) as? DICT else {return}
                guard let routes = reuslts["routes"] as? [DICT] else{ return}
                guard let legs = routes[0]["legs"] as? [DICT] else {return}
                guard let distance = legs[0]["distance"] as? DICT else {return}
                guard let text1 = distance["text"] as? String else {return}
                self.distanceAB = text1
                guard let duration = legs[0]["duration"] as? DICT else {return}
                guard let text2 = duration["text"] as? String else {return}
                self.time = text2
                guard let overview_polyline = routes[0]["overview_polyline"] as? DICT else {return}
                guard let points = overview_polyline["points"] as? String else {return}
                DispatchQueue.main.async {
                    self.showPath(polyStr: points)
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    //ve polyline cho 2 vi tri
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.strokeColor = UIColor.red
        polyline.map = mapView
        
    }
    override func viewDidAppear(_ animated: Bool) {
        distanceLb.text = distanceAB
        timeLb.text = time
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




   
    

