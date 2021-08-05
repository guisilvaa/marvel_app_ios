//
//  Character.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import ObjectMapper

class CharacterDataWrapper: Mappable {
    
    var data: CharacterDataContainer?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CharacterDataContainer: Mappable {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Character]?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
        results <- map["results"]
    }
}

class Character: Mappable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbImage: ThumbImage?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        thumbImage <- map["thumbnail"]
    }
}

class ThumbImage: Mappable {
    
    var path: String = ""
    var imageExtension: String = ""
    
    var imagePath: String { "\(path).\(imageExtension)" }
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        path <- map["path"]
        imageExtension <- map["extension"]
    }
}
