//
//  ViewController.swift
//  WikiLocation
//
//  Created by Christian Menschel on 27.06.14.
//  Copyright (c) 2014 enterprise. All rights reserved.
//

import UIKit
import GeoManager
import WikiManager

let kSegueIdentifier = "ShowWebDetails"
let kCellID = "WikiTableViewCellID"

class ViewController: UITableViewController {
    
    //MARK: - Properties
    let geoManager = GeoManager.sharedInstance
    var dataSource = [WikiArticle]()
    
    
    //MARK: - Init & deinit
    deinit {
        geoManager.removeObserver(self, forKeyPath: "location")
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        geoManager.addObserver(self, forKeyPath: "location", options: .New, context: nil)
        GeoManager.sharedInstance.start()
    }
    
    func loadWikisNearBy() {
        
        if let location = GeoManager.sharedInstance.location {
            WikiManager.sharedInstance.downloadWikis(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                completion: {(articles:[WikiArticle]) in
                    
                    self.dataSource = articles
                    self.tableView.reloadData()
                    
            })
        }
    }
    
    //MARK: - TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as UITableViewCell
        
        if let article = self.dataSource[indexPath.row] as WikiArticle? {
            cell.textLabel?.text = article.title
            cell.detailTextLabel?.text = article.distance
        }
        
        return cell
    }
    
let kSegueIdentifier = "ShowWebDetails"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == kSegueIdentifier {
            let indexPath = self.tableView.indexPathForSelectedRow();
            if let article = self.dataSource[indexPath!.row] as WikiArticle? {
                let webViewController:DetailViewController = segue.destinationViewController as DetailViewController
                webViewController.url = article.url
            }
        }
    }
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - KVO
    override func observeValueForKeyPath(keyPath: String!,
        ofObject object: AnyObject!,
        change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<()>) {
            
            if object === geoManager && keyPath == "location" {
                self.loadWikisNearBy()
            }
    }
}

