//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 10/05/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       #if swift(>=2.2)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusCahnged), name: "ReachStatusChanged", object: nil)
            
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusCahnged:", name: "ReachStatusChanged", object: nil)
            
        #endif
        #if swift(>=2.2)
                
      //          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
                
            #else
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
                
            #endif

        
        reachabilityStatusCahnged()
        
        
        
    }
    
    func preferredFontChange() {
        print("The Preferred Font has changed")
    }

    

    func didLoadData(videos: [Videos])  {
        
        print(reachabilityStatus)
        
        self.videos = videos
        

        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        tableView.reloadData()
        
        
    }
    
    
    func reachabilityStatusCahnged()
        
    {
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default){
                action -> () in
                print("Cancel")
                
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive){
                action -> () in
                print("Delete")
                
            }
            
            let okAction = UIAlertAction(title: "ok", style: .Default){
                action -> Void in
                print("Ok")
            
                
                //do somthing if you want
                //alert.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
//            
//        case WIFI : view.backgroundColor = UIColor.greenColor()
//       // displayLabel.text = "Reachable with WiFi"
//        case WWAN : view.backgroundColor = UIColor.yellowColor()
//       // displayLabel.text = "Reachable with Cellular"
//        default: return
           
                self.presentViewController(alert, animated: true, completion: nil)
                }
            default:
           // view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                
                runAPI()

            }
            
        }
        
        
    }
    
    func runAPI() {
        //call API
        let api = APIManager()
        api.loadData("http://itunes.apple.com/us/rss/topmusicvideos/limit=200/json",completion: didLoadData)
        
    }
    
    
    
    // its called just as the objact is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

      cell.video = videos[indexPath.row]
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier
        {
    if let indexpath = tableView.indexPathForSelectedRow {
        let video = videos[indexpath.row]
        let dvc = segue.destinationViewController as! MusicVideoDetailVC
        dvc.videos = video
    }
    }
    
     
     
 

//    func didLoadData(videos: [Videos]) {
//        
//        for item in videos {
//            
//            print("name = \(item.vName)")
//            
//            print("Image = \(item.vImageUrl)")
//            
//        }
}
}