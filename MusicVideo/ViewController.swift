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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
}