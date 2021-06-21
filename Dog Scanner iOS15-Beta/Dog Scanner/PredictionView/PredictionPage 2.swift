//
//  PredictionPage.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 10.06.21.
//

import SwiftUI

struct PredictionPage2: View {
    init(pht: Photo) {
        print("CAMM")
        photo = pht.image!
        print(predictionController.predict(image: pht.image!))
       
    }
    init () {
        print("Init lib")
        initCamera = false
        photo = UIImage()
    }

    @ObservedObject var lineViewController = LineViewController()
    @ObservedObject var predictionController = PredictionController()
    @State var photo: UIImage
    @State var showImagePicker = false
    @State var halfModalShown = false
    @State var breedIndex = 0
    @State var initCamera = true
    var capturedPhotoThumbnail: some View {
        Group {
            if photo != nil {
                Image(uiImage: photo)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                   .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                   .animation(.spring())
            }
       }
    }
    
    var body: some View {
        ZStack {
            Color("Background2")
                .ignoresSafeArea()
            VStack {
                 if initCamera {
                   
                    VStack {
                        //capturedPhotoThumbnailLib
                        capturedPhotoThumbnail
                        if predictionController.prediction[0].confidence < 0.22 {
                            Text("We think your dog is mixed between").font(.title).padding().multilineTextAlignment(.center)
                                .foregroundColor(Color("Text2"))
                            MixedBreedLineView(breeds: predictionController.prediction, lineViewController: lineViewController, halfModalShown: _halfModalShown, breedIndex: _breedIndex)
                        } else {
                            LineView(label: predictionController.prediction[0].label, probability: predictionController.prediction[0].confidence, lineViewController: lineViewController)
                        }
                        
                    }
                    
                } else {
                    Button("Pick image") {
                        self.showImagePicker.toggle()
                    }.onAppear(perform: triggerToggle)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    predictionController.predict(image: image)
                    self.photo = image
                    self.initCamera.toggle()
                }
            }
            if (initCamera) && photo != nil {
                HalfModalView(isShown: $halfModalShown, modalHeight: 300) {
                    Form {
                        Section(header: Text("Information")) {
                            HStack {
                                Text("Temperament")
                                Spacer()
                                Text(lineViewController.breedInfos[breedIndex].Temperment!)
                            }
                            HStack {
                                Text("Intelligence")
                                Spacer()
                                Text(String(format: "%.0f", lineViewController.breedInfos[breedIndex].Intelligence!))
                            }
                            HStack {
                                Text("Average male weight")
                                Spacer()
                                Text("\(String(format: "%.0f", lineViewController.breedInfos[breedIndex].MaleWtKg!)) kg")
                             }
                             HStack {
                                 Text("Average Puppy Price")
                                 Spacer()
                                 Text("\(String(format: "%.0f", lineViewController.breedInfos[breedIndex].AvgPupPrice!)) €")
                             }
                         }
                    }
                }
            }
        }
        
    }
    func triggerToggle() {
        showImagePicker.toggle()
    }
}

struct PredictionPage2_Previews: PreviewProvider {
    static var previews: some View {
        PredictionPage2(pht: Photo(originalData: Data()))
    }
}
