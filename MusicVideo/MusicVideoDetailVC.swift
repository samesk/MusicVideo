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
import LocalAuthentication


class MusicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    var securitySwitch:Bool = false
    
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
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            shareMedia()
        }
        
        
    }
    func touchIdChk() {
        
        //Create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // Create the local Authentication Context
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social media"
        
        
        // Check if we can access local device authantication
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&touchIDError){
            // Check what the authentication response was
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success {
                    // User authantication using local Device authentication Successfully!
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.shareMedia()
                        
                }
                    
                } else {
                    alert.title = "Unsuccessful!"
                    
                    switch LAError(rawValue: policyError!.code)! {
                        
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by application"
                        
                    case .AuthenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on the device"
                   
                    case .SystemCancel:
                        alert.message = "Authentication was cacelled by the system"
                   
                    case .TouchIDLockout:
                        alert.message = "Too many faild attempts."
                    
                    case .UserCancel:
                        alert.message = "You cancelled the request"
                    
                    case .UserFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                    
                    default:
                        alert.message = "Unable to Authantication!"
                        
                        
                    }
                   
                    
                    // Show the alert
                    dispatch_async(dispatch_get_main_queue()) { [ unowned self] in
                        self.presentViewController(alert, animated: true, completion: nil)
                    
                }
        }
        
    })
        } else{
            // Unable to access local vedice authentication
            
            // Set the error title
            alert.title = "Error"
            // Set the error alert message with more information
            switch LAError(rawValue: touchIDError!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
            
            case .TouchIDNotAvailable:
                alert.message = "Touch ID is not available it this device"
                
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .InvalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
                
            }
            // Show the alert
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            
        }
    
     }

        
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
