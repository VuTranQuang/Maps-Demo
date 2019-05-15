//
//  ViewController.swift
//  Maps-Demo
//
//  Created by Vu on 5/14/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit
import GoogleMaps
class VacationDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {
    var mapView: GMSMapView?
    var currentDestination: VacationDestination?
    let destinations = [VacationDestination(name: "Ho Guom", location: CLLocationCoordinate2DMake(21.028925, 105.852075), zoom: 15), VacationDestination(name: "Hoàng Đạo Thuý", location: CLLocationCoordinate2DMake( 21.007188, 105.802973), zoom: 18), VacationDestination(name: "VanTienDung", location: CLLocationCoordinate2DMake(21.057903, 105.751060), zoom: 18)]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        GMSServices.provideAPIKey("AIzaSyD9BAgTxpcz0HXQRLZcD1WEh06NQidVH2M")
        let camera = GMSCameraPosition.camera(withLatitude: 21.032652, longitude: 105.765653, zoom: 10)
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(21.032652, 105.765653)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Ký túc xá Mỹ Đình đơn nguyên 5"
        marker.map = mapView
       
    }
    
    @IBAction func Next(_ sender: UIBarButtonItem) {
        next()
    }
    func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.firstIndex(of: currentDestination!) {
                currentDestination = destinations[index + 1]
            }
        }
        setMapCamera()
       
    }
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: (currentDestination?.location)!, zoom: (currentDestination?.zoom)! ))
        CATransaction.commit()
        
        let marker = GMSMarker(position: (currentDestination?.location)!)
        marker.title = currentDestination?.name
        marker.map = mapView
    }


}

