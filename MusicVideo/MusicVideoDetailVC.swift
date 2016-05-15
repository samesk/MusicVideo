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
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        shareMedia()
        
    }
    
    func shareMedia(){
        
        let activity1 = "Have you had the oportunity to see this Video?"
        let activity2 = ("\(videos.vName), By \(videos.vArtist).")
        let activity3 = "Watch it and tell me what you tink !"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Share with the Music Videos App - Step it UP)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        //activityVieController.excludedActivityTypes = [UIActivityTypeMail]
        
        activityViewController.excludedActivityTypes = [
//        
//            UIActivityTypePostToTwitter,
//            UIActivityTypePostToFacebook,
//            UIActivityTypePostToWeibo,
//            UIActivityTypeMessage,
//            UIActivityTypeMail,
//            UIActivityTypePrint,
//            UIActivityTypeCopyToPasteboard,
//            UIActivityTypeAssignToContact,
//            UIActivityTypeSaveToCameraRoll,
//            UIActivityTypeAddToReadingList,
//            UIActivityTypePostToFlickr,
//        
            ]
        activityViewController.completionWithItemsHandler = {
            (activity, succses, item, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated:true, completion: nil)
    
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
