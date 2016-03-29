//
//  ViewController.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 26/03/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call API
        let api = APIManager()
        api.loadData("http://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion: didLoadData)
        
    }

    
    
    func didLoadData(result:String)  {
   
    
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
        
        
        }

        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}