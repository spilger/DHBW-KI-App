//
//  Types.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 16.06.21.
//

import Foundation

struct DogBreedCharacteristic: Decodable {
    let BreedName: String
    let AltBreedName: String?
    let Group1: String?
    let Group2: String?
    let MaleWtKg: Float?
    let Temperment: String?
    let AvgPupPrice: Float?
    let Intelligence: Float?
    let Watchdog: Float?
    let PopularityUS2017: Float?
}
 /*
    "BreedName":"Affenpinscher",
            "AltBreedName":null,
            "Group1":"Toy",
            "Group2":"Companion",
            "MaleWtKg":4.0,
            "Temperment":"Active, Adventurous, Curious, Fun-loving, Playful, Stubborn",
            "AvgPupPrice":1000.0,
            "Intelligence":37.0,
            "Watchdog":1.0,
            "MalaysiaGuardedDog":null,
            "MalaysiaProhibitedDog":null,
            "MalaysiaPopularity":null,
            "PopularityUS2017":147.0
            },*/

