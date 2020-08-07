//
//  User.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import ObjectMapper

class SuperHeroResponse: NSObject, Mappable{
    var error: String?
    var response: String?
    var superheroList: [SuperHero]?
    
    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        error <- map["error"]
        response <- map["response"]
        superheroList <- map["results"]
    }
}

class SuperHero: NSObject, Mappable{
    var id: String?
    var name: String?
    var biography: SuperHeroBiography?
    var image: SuperHeroImage?
    var powerstats: SuperHeroPowerstats?
    
    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        biography <- map["biography"]
        powerstats <- map["powerstats"]
    }
}

class SuperHeroBiography: NSObject, Mappable{
    var fullName: String?
    var alterEgos: String?
    var placeOfBirth: String?
    var firstAppearance: String?
    var publisher: String?
    var alignment: String?

    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        fullName <- map["full-name"]
        alterEgos <- map["alter-egos"]
        placeOfBirth <- map["place-of-birth"]
        firstAppearance <- map["first-appearance"]
        publisher <- map["publisher"]
        alignment <- map["alignment"]
    }
}

class SuperHeroPowerstats: NSObject, Mappable{
    var intelligence: String?
    var strength: String?
    var speed: String?
    var durability: String?
    var power: String?
    var combat: String?

    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        intelligence <- map["intelligence"]
        strength <- map["strength"]
        speed <- map["speed"]
        durability <- map["durability"]
        power <- map["power"]
        combat <- map["combat"]
    }
}


class SuperHeroImage: NSObject, Mappable{
    var url: String?
    
    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}
