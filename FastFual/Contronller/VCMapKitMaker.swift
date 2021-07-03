//
//  VCMapKitMaker.swift
//  FastFual
//
//  Created by macbook on 5/29/21.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation

class VCMapKitMaker:UIViewController{
    @IBOutlet var backButton: UIButton!

    @IBOutlet var mapView: GMSMapView!
    var test = 0
    var latitude = 0.0
        var longitude = 0.0
        var centerMapCoordinate:CLLocationCoordinate2D!
    private let locationManager = CLLocationManager()
    var marker: GMSMarker!
    var countryCode:String=""
    var country:String=""
    var address:String=""
  

    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buNext(_ sender: Any) {
    
        UserDefaults.standard.setValue(address, forKey: "address")
        UserDefaults.standard.setValue(latitude, forKey: "latitude")
        UserDefaults.standard.setValue(longitude, forKey: "longitude")
        UserDefaults.standard.setValue(true, forKey: "loc")

        navigationController?.popViewController(animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)


        checkLocationServices()
          locationManager.delegate = self

          locationManager.requestWhenInUseAuthorization()

        mapView.delegate = self
             locationManager.desiredAccuracy = kCLLocationAccuracyBest
             locationManager.startUpdatingLocation()

          guard let locValue = CLLocationManager.init().location?.coordinate  else { return }
          print("locations = \(locValue.latitude) \(locValue.latitude)")
          
          getAddressFromLatLon(pdblLatitude:"\(locValue.latitude)", withLongitude: "\(locValue.longitude)")
          let location = CLLocation(latitude: locValue.latitude, longitude:locValue.longitude)
          location.fetchCityAndCountry(from: location) { city, country, error in
              guard let city = city, let country = country, error == nil else { return }
              print(city + ", " + country)
}
    }
        func checkLocationServices() {
          if CLLocationManager.locationServicesEnabled() {
    //        checkLocationAuthorization()
          } else {
            // Show alert letting the user know they have to turn this on.
          }
        }

        func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
          for stadium in stadiums {
            let annotations = MKPointAnnotation()
            annotations.title = stadium.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: stadium.lattitude, longitude: stadium.longtitude)
//            mapView.addAnnotation(annotations)
            print( annotations.title)


          }
        }

        func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
                var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
                //21.228124
            latitude=lat
                let lon: Double = Double("\(pdblLongitude)")!
                //72.833770
            longitude=lon
                let ceo: CLGeocoder = CLGeocoder()
                center.latitude = lat
                center.longitude = lon

                let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


                ceo.reverseGeocodeLocation(loc, completionHandler:
                    {(placemarks, error) in
                        if (error != nil)
                        {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        }
                        let pm = placemarks! as [CLPlacemark]

                        if pm.count > 0 {
                            let pm = placemarks![0]
                            print(pm.country)
                            print(pm.locality)
                            print(pm.subLocality)
                            print(pm.thoroughfare)
                            print(pm.postalCode)
                            print(pm.subThoroughfare)
                            var addressString : String = ""
                            
                             if pm.isoCountryCode != nil {
                                 addressString = addressString + pm.isoCountryCode! + ""
                                 self.countryCode = pm.isoCountryCode!
                                print("Country Code \(self.countryCode)")
                             }
                            if pm.subLocality != nil {
                                addressString = addressString + pm.subLocality! + ""
                            }
                            if pm.thoroughfare != nil {
                                addressString =  addressString + pm.thoroughfare! + ""
                            }
                            if pm.locality != nil {
                                addressString =  addressString + pm.locality! + ""
                            }
                            if pm.country != nil {
                                addressString =  addressString + pm.country! + ""
                                self.country = pm.country!
                                print("Country \(pm.country!)")
                            }
                            if pm.postalCode != nil {
                                addressString = addressString + pm.postalCode! + " "
                            }


                            
                           self.address = addressString
                           print("addressString", addressString)
                         


                        }
                })

            }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
}

//1
extension VCMapKitMaker: CLLocationManagerDelegate {
  // 2
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.startUpdatingLocation()
      
    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
      
    // 7
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10, bearing: 0, viewingAngle: 0)
      
    // 8
    locationManager.stopUpdatingLocation()
  }
}


extension VCMapKitMaker: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //        latitude = mapView.camera.target.latitude
        //        longitude = mapView.camera.target.longitude
        //
        //        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        latitude = coordinate.latitude
         longitude = coordinate.longitude

        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
        getAddressFromLatLon(pdblLatitude: "\(latitude)", withLongitude: "\(longitude)")

        print("latitude \(latitude) ... longitude \(longitude)")


    }

    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {

        if marker == nil {
            marker = GMSMarker()
        }
        marker.position = centerMapCoordinate
        marker.map = self.mapView



    }
    }
