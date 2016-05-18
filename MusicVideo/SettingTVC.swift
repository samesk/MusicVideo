//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 12/05/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

   
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var imageQualityDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var slideCnt: UISlider!
        
    @IBOutlet weak var numberOfMusicVideos: UILabel!
    
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if swift(>=2.2)
            
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
            
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
            
        #endif
     
      tableView.alwaysBounceVertical = false
        
      title = "Setting"
        
      touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            slideCnt.value = Float(theValue)
        } else {
            slideCnt.value = 10.0
            APICnt.text = ("\(Int(slideCnt.value))")
        }
        
        
   
      }
    
    
    @IBAction func valueChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(slideCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(slideCnt.value))")
        
        
    }
    
    @IBAction func touchidSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
            
        }
        else
        {
            defaults.setBool(false, forKey: "SecSetting")
        
        }
    
    }
    
    
    
    func preferredFontChange(){
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        imageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfMusicVideos.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController  = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                
            }
            else {
                
                //No email account Setup on Phone
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
   
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["samuel.eskenasy@gmail.com",])
        mailComposeVC.setSubject("Music Video App FeedBack")
        mailComposeVC.setMessageBody("Hi Samuel, \n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail is setup for Phone", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
        //do somthing if you want
    }
    
     alertController.addAction(okAction)
       
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
            default:
            print("Unknown Issue")
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)}
    
    
    deinit
    
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    
}


