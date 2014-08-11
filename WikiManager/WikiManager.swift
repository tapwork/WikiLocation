//
//  WikiManager.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import Foundation

let wikilocationBaseURL = "http://api.wikilocation.org/"
let kBackgrounddownloadID = "net.tapwork.wikilocation.backgrounddownload.config"


public class WikiManager : NSObject {
    
    //MARK: - Properties
    public class var sharedInstance: WikiManager {
    struct SharedInstance {
        static let instance = WikiManager()
        }
        return SharedInstance.instance
    }
    
    
    //MARK: - Download
    func downloadURL(#url:NSURL,completion:((NSData!, NSError!) -> Void)) {
        
        let request: NSURLRequest = NSURLRequest(URL:url)
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        if UIApplication.sharedApplication().applicationState == .Background {
            config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(kBackgrounddownloadID)
        }
        
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(data, error)
            })
        });
        println("Download URL "+url.absoluteString)
        
        task.resume()
    }
    
    
    // NOTE: #major forces first parameter to be named in function call
    public func downloadWikis(#latitude:Double,longitude:Double,completion:(([WikiArticle]) -> Void))  {
        
        let fullURLString = wikilocationBaseURL +
        "articles?lat=\(latitude)&lng=\(longitude)&limit=10&radius=500"
        let url = NSURL(string: fullURLString)
        
        self.downloadURL(url: url) { (data, error) -> Void in
            var articles = NSMutableOrderedSet()
            if (data.length > 0) {
                var error:NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:&error) as Dictionary<String,AnyObject>
                
                if let jsonarticles = jsonResult["articles"] as? NSArray {
                    for item : AnyObject in jsonarticles {
                        var article = WikiArticle(json: item as Dictionary<String, AnyObject>)
                        articles.addObject(article)
                    }
                }
            }
            
            completion(articles.array as [WikiArticle])
        }
    }
}