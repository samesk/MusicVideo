//
//  APIManager.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 28/03/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import Foundation

class APIManager {

    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
           (data, response, error )->Void in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()){
                    completion(result: (error!.localizedDescription))
                }
            
            } else {
                
                //Added for JASONSerialization
               // print(date)
                do {
                    
                    /* .AllowFragments - top level objact is not Array or Dictionary.
                    Any type of string or value
                    NSJSONSerialization requires the Do /Try /Catch
                    Converts the NSDATA into a JSON Objact and it to a Dictionary */
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: . AllowFragments)
                        as? [String: AnyObject]{
                        
                            print(json)
                        
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "NSJSONSerialization Successful")
                            }
                            
                        }
                        
                    }
                }catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in NSJSONSerialization")
                    }
                }
                    
                
                
            }
                    }
            
            
            task.resume()
        }
        
}


    

