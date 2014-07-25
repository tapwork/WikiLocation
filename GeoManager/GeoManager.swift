//
//  GeoManager.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoManager : NSObject, CLLocationManagerDelegate {
    
    //#pragma mark - Properties
    var locationManager:CLLocationManager = CLLocationManager()
    private(set)  var location:CLLocation?
    var locationAuthorized = false
    
    public class var sharedInstance: GeoManager {
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
    public func start() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if self.isLocatingAllowed() {
            self.locationAuthorized = true
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest  // Meter
            self.locationManager.startUpdatingLocation()
        }
    }
    
    public func stop() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    func isLocatingAllowed() -> Bool {
        var allowed = false
        
        if CLLocationManager.locationServicesEnabled() == true {
            allowed = true
        }
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            allowed = true
        } else {
            allowed = false
        }
        
        return allowed
    }
    
    //#pragma mark - CLLocationManagerDelegate
    public func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            if locations.count > 0 && self.location == nil {
            self.location = locations[0] as? CLLocation
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    public func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    public func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (!self.locationAuthorized && status == .AuthorizedWhenInUse) {
            // Location service was not enabled before - now start the location service again
            self.start()
        }
    }
    
    //#pragma mark - Notifications
    func didEnterBackground(notification:AnyObject) {
        self.stop()
        // also destroy the latest location - we refresh when coming into foreground
        self.location = nil
    }
    
    func didEnterForeground(notification:AnyObject) {
        self.start()
    }
}
