//
//  MapViewController2.swift
//  MADAssignment2
//
//  Created by Heja Bibani on 30/9/22.
//

import Foundation

import UIKit
import MapKit


//This is the mapview controller to go to map of location of shop
class MapViewController2: UIViewController, MKMapViewDelegate {

    //set the tool bar
    var toolBar = UIToolbar()

    //produce the mapview parameters
    let map: MKMapView = {
        let map = MKMapView();
        map.overrideUserInterfaceStyle = .dark;
        return map
    }()
    
    //string for the address
    var addressmap : String = ""
    
    //distance of the map in general
    var mapDistance : Double = 1000

override func viewDidLoad() {
    super.viewDidLoad()
    map.delegate = self;
    view.addSubview(map);
    title = "Bar Items"

    //set bar button item
    var items = [UIBarButtonItem]();
    //click done bar button item
    items.append(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didtouchMethod1 )))
    self.toolbarItems = items;
    self.navigationController?.isToolbarHidden = false;
    //self.navigationController?.toolbar.setItems(items, animated: false)
    
    //position tool bar top left
    toolBar.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 100)
    toolBar.setItems(items, animated: false)
    //toolBar.barStyle = UIBarStyle.black;
    
    //add toolbar to the view
    self.view.addSubview(toolBar)
    
    //set position of mapview underneath the toolbar
    map.frame = CGRect(x:3, y:toolBar.frame.height, width:view.bounds.size.width, height:view.bounds.size.height);

  
    map.showsUserLocation = true
    
    
    //if the address is nothing then position to sydney else use geocoder to get location
    if addressmap == "" {
        let sydneyCenter = CLLocation(latitude: -33.8688, longitude: 151.2093)
        let region = MKCoordinateRegion (center: sydneyCenter.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        map.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: mapDistance)
        map.setCameraZoomRange(zoomRange, animated: true)
    }
    else {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressmap, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error!)
                return
            }//place annotation marker on the map
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.addressmap
                //show annotation on map
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.map.showAnnotations([annotation], animated: true)
                    self.map.selectAnnotation(annotation, animated: true)
                }
            }
        })
        map.delegate = self
    }
    

    // Do any additional setup after loading the view.
}
    // when button is clicked dismiss current page to go back to main page
    @objc func didtouchMethod1()
    {
        self.dismiss(animated: true, completion: nil)
    }

}
