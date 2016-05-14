//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 12/05/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

   
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
            
            //                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
            //
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
    
    deinit
    
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    
}

    
