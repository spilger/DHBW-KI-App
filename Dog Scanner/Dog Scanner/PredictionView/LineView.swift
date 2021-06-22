//
//  LineView.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 16.06.21.
//

import SwiftUI

struct LineView: View {
    init(label: String, probability: Float, lineViewController: LineViewController) {
        self.lineViewController = lineViewController
        breedInfo = lineViewController.matchDogBreed(breedName: label)
        prb = String(format: "%.0f", probability*100) + " %"
        lbl = label.components(separatedBy: "-")[1].replacingOccurrences(of: "_", with: " ")
        print(lbl)
    }
    @ObservedObject var lineViewController: LineViewController
    var breedInfo: DogBreedCharacteristic?
    var lbl: String
    var  prb: String
    var body: some View {
        Form {
            Section(header: Text("Dog Breed")) {
               HStack {
                   Text(lbl.capitalized)
                   Spacer()
                   Text(prb)
               }
            }
           Section(header: Text("Information")) {
               HStack {
                   Text("Temperament")
                   Spacer()
                   Text(breedInfo!.Temperment!)
               }
               HStack {
                   Text("Intelligence")
                   Spacer()
                   Text(String(format: "%.0f", breedInfo!.Intelligence!))
               }
               HStack {
                   Text("Average male weight")
                   Spacer()
                   Text("\(String(format: "%.0f", breedInfo!.MaleWtKg!)) kg")
                }
                HStack {
                    Text("Average Puppy Price")
                    Spacer()
                    Text("\(String(format: "%.0f", breedInfo!.AvgPupPrice!)) €")
                }
            }
            
        }
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(label: "Labrador", probability: 0.9, lineViewController: LineViewController())
    }
}
