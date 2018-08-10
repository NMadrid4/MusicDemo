//
//  Music.swift
//  YoutubeDemo
//
//  Created by Nicolas on 9/08/18.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Music {
    var id: Int
    var title: String
    var author: String
    var song: String
    var image: String
    
    init(id: Int, title: String, author:String, song: String, image: String) {
        self.id = id
        self.title = title
        self.author = author
        self.song = song
        self.image = image
    }
    
    static func from(json: JSON) -> Music {
        return Music(id: json["id"].intValue, title: json["title"].stringValue,
                     author: json["author"].stringValue, song: json["track"].stringValue, image: json["image"].stringValue)
    }
    
    static func from(jsonArray: [JSON]) -> [Music] {
        var resultArray: [Music] = []
        for jsonSong in jsonArray {
            resultArray.append(Music.from(json: jsonSong))
        }
        return resultArray
    }
    
}


