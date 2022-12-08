//
//  Location.swift
//  Weather
//
//  Created by Robert Dodson on 11/9/22.
//

import Foundation
import CoreLocation

class Location : NSObject, CLLocationManagerDelegate
{
    var locationManager = CLLocationManager()
    var mylocations : [CLLocation]?
    
   override init()
    {
      super.init()
        
        locationManager.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
   }
    
    func haveLocation() -> Bool
    {
        if mylocations != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func getLocations() -> [CLLocation]
    {
        return mylocations ?? Array<CLLocation>()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("LocationManager didUpdateLocations: numberOfLocation: \(locations.count)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
        mylocations = locations
        
        /*
        locations.forEach
        { (location) in
        
          print("LocationManager didUpdateLocations: \(dateFormatter.string(from: location.timestamp)); \(location.coordinate.latitude), \(location.coordinate.longitude)")
          print("LocationManager altitude: \(location.altitude)")
        print("LocationManager floor?.level: \(String(describing: location.floor?.level))")
          print("LocationManager horizontalAccuracy: \(location.horizontalAccuracy)")
          print("LocationManager verticalAccuracy: \(location.verticalAccuracy)")
          print("LocationManager speedAccuracy: \(location.speedAccuracy)")
          print("LocationManager speed: \(location.speed)")
          print("LocationManager timestamp: \(location.timestamp)")
          print("LocationManager courseAccuracy: \(location.courseAccuracy)") // 13.4
          print("LocationManager course: \(location.course)")
        }
         */
      }
          
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("LocationManager didFailWithError: \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied
        {
           // Location updates are not authorized.
          // To prevent forever looping of `didFailWithError` callback
           locationManager.stopMonitoringSignificantLocationChanges()
           return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
            case .denied: // Setting option: Never
              print("LocationManager didChangeAuthorization denied")
            case .notDetermined: // Setting option: Ask Next Time
              print("LocationManager didChangeAuthorization notDetermined")
            case .authorizedWhenInUse: // Setting option: While Using the App
              print("LocationManager didChangeAuthorization authorizedWhenInUse")
              
              // Stpe 6: Request a one-time location information
              locationManager.requestLocation()
            case .authorizedAlways: // Setting option: Always
              print("LocationManager didChangeAuthorization authorizedAlways")
              
              // Stpe 6: Request a one-time location information
              locationManager.requestLocation()
            case .restricted: // Restricted by parental control
              print("LocationManager didChangeAuthorization restricted")
            default:
              print("LocationManager didChangeAuthorization")
        }
    }
  

}
