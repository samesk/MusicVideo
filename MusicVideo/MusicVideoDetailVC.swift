//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 11/05/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("preferredFontChange:"), name: UIContentSizeCategoryDidChangeNotification, object: nil)
//        

        
        
        title = videos.vArtist
       vName.text = videos.vName
       vPrice.text = videos.vPrice
       vRights.text = videos.vRights
       vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
      
        
        
    }
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
       
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true){ playerViewController.player?.play()
        
        
        }
        
        
    }
   

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
}
