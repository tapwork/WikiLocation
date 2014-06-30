//
//  GeoManager.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import Foundation
import CoreLocation

class GeoManager : NSObject, CLLocationManagerDelegate {
    
    //#pragma mark - Properties
    var locationManager:CLLocationManager = CLLocationManager()
    var location:CLLocation?
    
    class var sharedInstance: GeoManager {
    struct SharedInstance {
        static let instance = GeoManager()
        }
        return SharedInstance.instance
    }
    
    //#pragma mark - Init & deinit
    init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackground:",
            name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackground:",
            name: UIApplicationWillTerminateNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterForeground:",
            name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //#pragma mark - Start & Stop
    func startAll() {
        
        self.locationManager.requestAlwaysAuthorization()
        
        if self.isLocatingAllowed() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = 300  // Meter
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopAll() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    func isLocatingAllowed() -> Bool {
        var allowed = true
        if CLLocationManager.locationServicesEnabled() == false {
            allowed = false
        }
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
            allowed = false
        }
        
        return allowed
    }
    
    //#pragma mark - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        
        if locations.count > 0 && self.location == nil {
            self.location = locations[0] as? CLLocation
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    //#pragma mark - Notifications
    func didEnterBackground(notification:AnyObject) {
        self.locationManager.stopUpdatingLocation()
        // also destroy the latest location - we refresh when coming into foreground
        self.location = nil
    }
    
    func didEnterForeground(notification:AnyObject) {
        self.locationManager.startUpdatingLocation()
    }
}