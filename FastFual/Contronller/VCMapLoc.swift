//
//  VCMapLoc.swift
//  FastFual
//
//  Created by macbook on 6/5/21.
//

import UIKit
import Alamofire
import ObjectMapper
import MapKit
import GoogleMaps
import CoreLocation
import GooglePlaces
enum Location {
    case startLocation
    case destinationLocation
}

class VCMapLoc: UIViewController,GMSMapViewDelegate ,CLLocationManagerDelegate  , UITextViewDelegate {
    @IBOutlet var backButton: UIButton!

    var  sdata:[searchData]=[]
    @IBOutlet var searchBar: SearchView!
    var result : [searchData]=[]
    var lat:[Double]=[]
    var long:[Double]=[]
    var centerMapCoordinate:CLLocationCoordinate2D!
private let locationManager = CLLocationManager()
    var marker: GMSMarker!
    var countryCode:String=""
    var country:String=""
    var address:String=""
    @IBOutlet weak var googleMaps : GMSMapView!
        var tolatitudeToSend = 0.0
        var tolongitudeToSend = 0.0
    
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
        var isToAddresCome = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)

        searchBar.startHandler {
                }
                searchBar.endEditingHandler {
                    if (self.searchBar.txtSearch.text)?.count != 0{
                        self.search(searchText:self.searchBar.txtSearch.text!)
                        
                    }else{
             
                    }
                    
                }

     
    }
    func getLocation(){
        if result.count != 0{
            for index in 0 ... result.count-1{
                lat.append(result[index].lat ?? 0.0)
                long.append(result[index].lng ?? 0.0)
 
            }
            

        }else{
            
        }
        print(lat)
        print(long)

        setLoc()
    }

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func filter(keyword : String) -> [searchData]{
        lat=[]
        long=[]
       result = sdata.filter({ (resl) -> Bool in
        return  (resl.company_name?.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
        print(result)
        self.getLocation()

        
        return result
    }

}
extension VCMapLoc{
    
    func setLoc(){
        if lat.count != 0{
            for index in 0 ... lat.count-1{
                setLocation(pdblLatitude: "\(lat[index])", pdblLongitude: "\(long[index])")
            }
            
        }
    
        
    }
    
    private func search(searchText:String){
        
       
        let parameters: Parameters = [
            "text":searchText,
            "type" : 0
           
            ]

            
            Alamofire.request(API_KEYS.postsearch.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : search = Mapper<search>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata=parsedMapperString.data ?? []
                            self.filter(keyword:self.searchBar.txtSearch.text!)

                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
          
            }
  

    }
}
extension VCMapLoc{
    

    
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
    func setLocation(pdblLatitude: String,pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lats: Double = Double(pdblLatitude) ?? 0.0
        print(lats)

        //21.228124
        let lons: Double = Double(pdblLongitude) ?? 0.0
        print(lons)

        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lats
        center.longitude = lons
        print( center.latitude)
        print( center.longitude)

        let camera = GMSCameraPosition.camera(withLatitude:  center.latitude, longitude: center.longitude, zoom: 2.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        googleMaps.camera=camera
        googleMaps.frame=CGRect.zero
        //        view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:  center.latitude, longitude: center.longitude)
//        marker.title = "CarLocation"
//        marker.snippet = "Australia"
        marker.map = googleMaps

    }

}
//}
//extension VCMapLoc{
//  // 2
//  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    // 3
//    guard status == .authorizedWhenInUse else {
//      return
//    }
//    // 4
//    locationManager.startUpdatingLocation()
//
//    //5
//    googleMaps.isMyLocationEnabled = true
//    googleMaps.settings.myLocationButton = true
//  }
//
//  // 6
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    guard let location = locations.first else {
//      return
//    }
//
//    // 7
//    googleMaps.camera = GMSCameraPosition(target: location.coordinate, zoom: 10, bearing: 0, viewingAngle: 0)
//
//    // 8
//    locationManager.stopUpdatingLocation()
//  }
//}
//
//
//extension VCMapLoc{
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        //        latitude = mapView.camera.target.latitude
//        //        longitude = mapView.camera.target.longitude
//        //
//        //        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        //        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
//    }
//
//    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
//
//        if marker == nil {
//            marker = GMSMarker()
//        }
//        marker.position = centerMapCoordinate
//        marker.map = self.googleMaps
//
//
//
//    }
//    }
//
//extension VCMapLoc{
//
//  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//      googleMaps.isMyLocationEnabled = true
//  }
//
//  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//      googleMaps.isMyLocationEnabled = true
//
//      if (gesture) {
//          mapView.selectedMarker = nil
//      }
//  }
//
//  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//      googleMaps.isMyLocationEnabled = true
//      return false
//  }
//
//  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//      print("COORDINATE \(coordinate)") // when you tapped coordinate
//
//      self.googleMaps.clear()
//      self.createMarker(titleMarker: "مكان التسليم" , iconMarker: #imageLiteral(resourceName: "Group 351") , latitude: coordinate.latitude , longitude: coordinate.longitude)
//
//      self.mylatitudeToSend = coordinate.latitude
//      self.mylongitudeToSend = coordinate.longitude
//
//
//  }
//
//  func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//      googleMaps.isMyLocationEnabled = true
//      googleMaps.selectedMarker = nil
//      return false
//  }
//
//
//
//
//}

