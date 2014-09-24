//
//  WikiArticle.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import Foundation

public class WikiArticle : NSObject {
    
    //Mark: - Properties
    public let distance:String!
    public let identifier:Int!
    public let latitutde:Double!
    public let longitude:Double!
    public let url:NSURL!
    public let title:String!
    
    //MARK: - Init
    init(json:Dictionary<String,AnyObject>) {
        super.init()
        
        if let title = json["title"] as? NSString {
            self.title = title
        }
        if let distance = json["dist"] as? NSNumber {
            self.distance = NSString(format: "Distance: %.2f Meter", distance.doubleValue)
        }
        if let id = json["pageid"] as? NSNumber {
            self.identifier = id.integerValue
        }
        if let latitutde = json["lat"] as? NSNumber {
            self.latitutde = latitutde.doubleValue
        }
        if let longitude = json["lon"] as? NSNumber {
            self.longitude = longitude.doubleValue
        }
        self.url = NSURL(string: "http://en.wikipedia.org/wiki?curid=\(self.identifier)")
    }
    
    //MARK: - Equality
    func hash() -> Int {
        return self.title.hash
    }
    
    override public func isEqual(object: AnyObject!) -> Bool {
        if self === object ||
            self.hash == object.hash {
                return true
        }
        return false
    }
}