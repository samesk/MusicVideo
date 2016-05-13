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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if swift(>=2.2)
            
            //                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
            //
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
            
        #endif
     
      tableView.alwaysBounceVertical = false
   
      }
    func preferredFontChange(){
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        imageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit
    
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    
}

    
