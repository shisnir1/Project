

import UIKit
import MapKit

class LocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
   fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMapView()
    }
    
    //MARK: - Setup Methods
    func setUpMapView() {
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.mapType = .standard
        self.getUsercurrentLocation()
    }
    //MARK: - Helper Method
        func getUsercurrentLocation() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if #available(iOS 11.0, *) {
                locationManager.showsBackgroundLocationIndicator = true
            }
            locationManager.startUpdatingLocation()
        }
        
        /// Function to add Annotation on Map
        /// - Parameter cordinates: location Cordinates
        func addAnnotationsOnMapView(cordinates: CLLocationCoordinate2D) {
            let london = MKPointAnnotation()
            london.title = "Annotation"
            london.subtitle = "Sub Annotation"
            london.coordinate = cordinates
            mapView.addAnnotation(london)
        }
        
       
    var latitude : Double = 28.6139
    var longitude : Double = 77.2090
    func geocode(latitude: Double, longitude: Double)  {
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemark, error in
                guard let placemark = placemark, error == nil else {
                    return
                }
                print(placemark)
            }
        }
    }

    //MARK: - CLLocationManagerDelegate Methods
            let cordinates = [51.5074,0.1278]
    extension LocationViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last! as CLLocation
            let currentLocation = location.coordinate
            self.addAnnotationsOnMapView(cordinates: currentLocation)
            self.geocode(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
           // locationManager.stopUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            print(status)
        }
    }

    extension LocationViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
    }

