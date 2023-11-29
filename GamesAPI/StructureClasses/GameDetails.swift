//
//  GameDetails.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit

class GameDetails: NSObject {
    var id : Int
    var title : String
    var thumbnail : String
    var short_description : String
    var genre : String
    var platform : String
    var publisher : String
    var developer : String
    var release_date : String
    
    init(dict : [String : Any]){
        id = dict["id"] as! Int
        title = dict["title"] as!String
        thumbnail = dict["thumbnail"] as! String
        short_description = dict["short_description"] as! String
        genre = dict["genre"] as! String
        platform = dict["platform"] as! String
        publisher = dict["publisher"] as! String
        developer = dict["developer"] as! String
        release_date = dict["release_date"] as! String
    }
}
