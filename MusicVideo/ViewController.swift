//
//  ViewController.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 26/03/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
       reachabilityStatusCahnged()
        
        //call API
        let api = APIManager()
        api.loadData("http://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion: didLoadData)
        
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
}