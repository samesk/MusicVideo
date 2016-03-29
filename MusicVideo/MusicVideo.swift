//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Samuel Eskenasy on 29/03/2016.
//  Copyright © 2016 Samuel Eskenasy. All rights reserved.
//

import Foundation

class Videos  {

    //Data encapsulation
    
    private var _vName:String
    
    private var _vImageUrl:String
    
    private var _vVideoUrl:String
    
    //Make a getter
    
    var vName:  String{
        return _vName
        
    }
    
    var vImageUtl: String{
        return _vImageUrl
        
    }
    
    var vVideoUrl:String{
        
        return _vVideoUrl
        
    }
    
    init(data: JSONDictionary){
    
        //If we do not initialize all properties we will get error message 
        
        //VideName
        
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["lable"] as? String {
            self._vName = vName
        
    } else {
    
            
        //You may not always get data back from the JSON - you may want to get massage
        // element in the JSON is unexpected
        _vName = ""
        
        }
    
    // The Video Image
        
        if let img  = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["lable"] as? String{
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else {
            
            _vImageUrl = ""
        }
    //Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
            
        }
    
    
    
    
    
    }
    
}