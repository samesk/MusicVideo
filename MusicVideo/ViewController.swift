//
//  ViewController.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 26/03/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {

   var videos = [Videos]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
           #if swift(>=2.2)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusCahnged), name: "ReachStatusChanged", object: nil)

        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusCahnged:", name: "ReachStatusChanged", object: nil)
            
        #endif

        
        reachabilityStatusCahnged()
   
        //call API
        let api = APIManager()
        api.loadData("http://itunes.apple.com/us/rss/topmusicvideos/limit=50/json",completion: didLoadData)
        
    }

    
    func didLoadData(videos: [Videos])  {
   
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate(){
                print("\(index) name = \(item.vName)")
        }
    tableView.reloadData()
    
    
    }
    
    
    func reachabilityStatusCahnged()
    
    {
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        displayLabel.text = "Reachable with WiFi"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = "Reachable with Cellular"
        default: return
        }
        
    }
    // its called just as the objact is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        
        cell.detailTextLabel?.text = video.vName
        return cell
    
    }
    
    



}
