//
//  PredictionPage.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 10.06.21.
//

import SwiftUI

struct PredictionPage: View {
    init(pht: Photo) {
        self.photoCam = pht.image!
        print(predictionController.predict(image: pht.image!))
    }
    init() {
        initCamera = false
        photoCam = UIImage()
    }
    @ObservedObject var lineViewController = LineViewController()
    @ObservedObject var predictionController = PredictionController()
    @State var photo: UIImage?
    @State var photoCam: UIImage
    @State var showImagePicker = false
    @State var halfModalShown = false
    @State var breedIndex = 0
    var initCamera = true
    var capturedPhotoThumbnail: some View {
        Group {
            if photo != nil {
                Image(uiImage: photo!)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                   .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                   .animation(.spring())
            } else if photoCam != nil {
                Image(uiImage: photoCam)
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
                if(photo == nil && !initCamera) {
                    Button("Pick image") {
                        self.showImagePicker.toggle()
                    }.onAppear(perform: triggerToggle)
                } else {
                   
                    VStack {
                        capturedPhotoThumbnail
                        if predictionController.prediction[0].confidence < 0.22 {
                            Text("We think your dog is mixed between").font(.title).padding().multilineTextAlignment(.center)
                                .foregroundColor(Color("Text2"))
                            MixedBreedLineView(breeds: predictionController.prediction, lineViewController: lineViewController, halfModalShown: _halfModalShown, breedIndex: _breedIndex)
                        } else {
                            LineView(label: predictionController.prediction[0].label, probability: predictionController.prediction[0].confidence, lineViewController: lineViewController)
                        }
                        
                    }
                    
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.photo = image
                    predictionController.predict(image: image)
                }
            }
            if photo != nil || initCamera {
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
                                Text(String(format: "%.0f", lineViewController.breedInfos[breedIndex].Intelligence ?? 0.0))
                            }
                            HStack {
                                Text("Average male weight")
                                Spacer()
                                Text("\(String(format: "%.0f", lineViewController.breedInfos[breedIndex].MaleWtKg ?? 0.0)) kg")
                             }
                             HStack {
                                 Text("Average Puppy Price")
                                 Spacer()
                                 Text("\(String(format: "%.0f", lineViewController.breedInfos[breedIndex].AvgPupPrice ?? 0.0)) €")
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

struct PredictionPage_Previews: PreviewProvider {
    static var previews: some View {
        PredictionPage(pht: Photo(originalData: Data()))
    }
}
