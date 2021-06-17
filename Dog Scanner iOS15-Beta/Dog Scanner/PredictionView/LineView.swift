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
        print(breedInfo)
        prb = String(format: "%.2f", probability)
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
                    Text(lbl)
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
            }
            
        }
        /*VStack {
            Text(lbl + " " + prb).padding().font(.title3)
            if breedInfo != nil {
                Form {
                    Section(header: Text("")) {
                        HStack {
                            Text(lbl)
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
                    }
                }
                /*HStack {
                    VStack {
                        Text("Temperament:")
                    }.padding()
                    VStack {
                        Text(breedInfo!.Temperment!)
                    }.padding()
                }
                HStack {
                    VStack {
                        Text("Intelligence:")
                        Text("Average male weight:")
                    }.padding()
                    VStack {
                        Text(String(format: "%.0f", breedInfo!.Intelligence!))
                        Text("\(String(format: "%.0f", breedInfo!.MaleWtKg!)) kg")
                    }.padding()
                }*/
            }
        }.frame(width: UIScreen.screenWidth * 0.9, alignment: .center)
        .background(Color("Background"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)*/
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(label: "Labrador", probability: 0.9, lineViewController: LineViewController())
    }
}
