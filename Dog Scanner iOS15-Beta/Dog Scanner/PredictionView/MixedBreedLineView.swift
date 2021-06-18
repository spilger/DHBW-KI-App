//
//  MixedBreedLineView.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 18.06.21.
//

import SwiftUI

struct MixedBreedLineView: View {
    init(breeds: [Inference], lineViewController: LineViewController, halfModalShown: State<Bool>, breedIndex: State<Int>) {
        self._breedIndex = breedIndex
        self._halfModalShown = halfModalShown
        self.lineViewController = lineViewController
        self.breeds = []
        self.breedInfos = []
        for brd in breeds {
            self.breeds.append(Inference(confidence: brd.confidence, label: brd.label.components(separatedBy: "-")[1].replacingOccurrences(of: "_", with: " ")))
            self.breedInfos.append(lineViewController.matchDogBreed(breedName: brd.label)!)
        }
        lineViewController.breedInfos = self.breedInfos
    }
    @ObservedObject var lineViewController: LineViewController
    var breeds: [Inference]
    var breedInfos: [DogBreedCharacteristic]
    @State var breedIndex: Int
    @State var halfModalShown: Bool
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Dog Breeds")) {
                    ForEach(0..<breeds.count) { i in
                        Button(action: {
                            breedIndex = i
                            halfModalShown.toggle()
                        }) {
                            HStack {
                                Text(breeds[i].label.capitalized)
                                Spacer()
                                Text(String(format: "%.0f", breeds[i].confidence * 100) + " %")
                            }
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct MixedBreedLineView_Previews: PreviewProvider {
    static var previews: some View {
        MixedBreedLineView(breeds: [], lineViewController: LineViewController(), halfModalShown: State(initialValue: false), breedIndex: State(initialValue: 0))
    }
}
