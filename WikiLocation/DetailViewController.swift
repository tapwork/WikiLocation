//
//  DetailViewController.swift
//  WikiLocation
//
//  Created by Christian Menschel on 29.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet var webView : UIWebView
    var url:NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let anURL = self.url {
            let request = NSURLRequest(URL: anURL)
            self.webView.loadRequest(request)
        }
    }
}