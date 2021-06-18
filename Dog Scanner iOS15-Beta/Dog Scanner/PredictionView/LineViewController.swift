//
//  LineViewController.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 16.06.21.
//

import Foundation
import SwiftUI


class LineViewController: ObservableObject {
    
    var dogBreedData: [DogBreedCharacteristic] = []
    var breedInfos: [DogBreedCharacteristic] = []
    func matchDogBreed(breedName: String) -> DogBreedCharacteristic? {
        let bdn = formatString(s: breedName.components(separatedBy: "-")[1])
        print(bdn)
        for db in dogBreedData {
            let d = formatString(s: db.BreedName)
            if d.contains(bdn) {
                self.breedInfos.append(db)
                return db
            }
        }
        return nil
    }
    
    init() {
        
        do {
            if let jsonURL = Bundle.main.url(forResource: "DogBreedCharactaristics", withExtension: "json") {
                let jsonData = try Data(contentsOf: jsonURL)
                let jsonDecoder = JSONDecoder()
                let breeds = try jsonDecoder.decode([DogBreedCharacteristic].self, from: jsonData)
                self.dogBreedData = breeds
            }
            
        } catch {print(Error.self)}
        
    }
    private func formatString(s:String) -> String {
        return s.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "_", with: "").replacingOccurrences(of: "-", with: "").lowercased()
    }
}
