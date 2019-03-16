//
//  MapViewController.swift
//  Unihack2019
//
//  Created by Gabrielle Chandrasaputra on 16/3/19.
//  Copyright © 2019 Gabrielle Chandrasaputra. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

final class RestaurantAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
}
class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let initialLocation = CLLocation(latitude: -37.8100565, longitude: 144.9643151)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        loadInitialData()
        print("rest: \(restaurants)")
        mapView.addAnnotations(restaurants)
        
//        let artwork = Restaurant(title: "Starbucks",
//                              locationName: " Melbourne Central, 151/377-391 Swanston St, Melbourne VIC 3000",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: -37.814, longitude: 144.96))
//        mapView.addAnnotation(artwork)
        }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = works.compactMap { Restaurant(json: $0) }
        restaurants.append(contentsOf: validWorks)
    }
    
}
extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Restaurant else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Restaurant
        performSegue(withIdentifier: "goToRestaurant", sender: nil)
    }
}
