//
//  SingleGamedetails.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit

class SingleGamedetails: NSObject {
    var id : Int
    var title : String
    var thumbnail : String
    var status : String
    var short_description : String
    var descriptiion : String
    var genre : String
    var platform : String
    var publisher : String
    var developer : String
    var release_date : String
    var minimum_system_requirements : [String : Any]?
    var screenshots : [[String : Any]]
    
    init(dict : [String : Any]){
        id = dict["id"] as! Int
        title = dict["title"] as!String
        thumbnail = dict["thumbnail"] as! String
        status = dict["status"] as! String
        short_description = dict["short_description"] as! String
        descriptiion = dict["description"] as! String
        genre = dict["genre"] as! String
        platform = dict["platform"] as! String
        publisher = dict["publisher"] as! String
        developer = dict["developer"] as! String
        release_date = dict["release_date"] as! String
        minimum_system_requirements = dict["minimum_system_requirements"] as? [String : Any]
        screenshots = dict["screenshots"] as! [[String : Any]]
    }
}
