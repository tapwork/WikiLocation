//
//  WikiArticle.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

class WikiArticle : NSObject {
    
    //#pragma mark - Properties
    let distance:String!
    let id:Integer!
    let latitutde:Double!
    let longitude:Double!
    let url:NSURL!
    let title:String!
    let type:String!
    
    //#pragma mark - Init
    init(json:Dictionary<String,AnyObject>) {
        super.init()
        
        if let title = json["title"] as? NSString {
            self.title = title
        }
        if let type = json["type"] as? NSString {
            self.type = type
        }
        if let distance = json["distance"] as? NSString {
            self.distance = distance
        }
        if let mobileurl = json["mobileurl"] as? NSString {
            self.url = NSURL(string: mobileurl )
            
        }
        if let id = json["id"] as? NSString {
            self.id = id.integerValue
        }
        if let latitutde = json["lat"] as? NSString {
            self.latitutde = latitutde.doubleValue
        }
        if let longitude = json["lng"] as? NSString {
            self.longitude = longitude.doubleValue
        }
    }
    
    //#pragma mark - Equality
    func hash() -> Int {
        return self.title.hash
    }
    
    override func isEqual(object: AnyObject!) -> Bool {
        if self === object ||
            self.hash == object.hash {
                return true
        }
        return false
    }
}