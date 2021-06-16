//
//  PredictionPage.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 10.06.21.
//

import SwiftUI

struct PredictionPage: View {
    init(photo: Photo) {
        self.photo = photo.image!
        print(predictionController.predict(image: photo.image!))
    }
    init() {
        
    }
    @ObservedObject var predictionController = PredictionController()
    @State var photo: UIImage?
    @State var showImagePicker = false
    var capturedPhotoThumbnail: some View {
        Group {
            if photo != nil {
                Image(uiImage: photo!)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                   .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                   .animation(.spring())
            }
       }
    }
    
    var body: some View {
        VStack {
            if(photo == nil) {
                Button("Pick image") {
                    self.showImagePicker.toggle()
                }.onAppear(perform: triggerToggle)
            } else {
                ScrollView {
                    VStack {
                        capturedPhotoThumbnail
                        Text("Predictions").bold().font(.largeTitle)
                        if predictionController.prediction[0].confidence < 0.22 {
                            Text("We think your Dog is mixed between").padding().font(.title)
                            ForEach(predictionController.prediction, id: \.self) { d in
                                LineView(label: d.label, probability: d.confidence).padding()
                            }
                        } else {
                            LineView(label: predictionController.prediction[0].label, probability: predictionController.prediction[0].confidence)
                        }
                        
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
        
    }
    func triggerToggle() {
        showImagePicker.toggle()
    }
}

struct PredictionPage_Previews: PreviewProvider {
    static var previews: some View {
        PredictionPage(photo: Photo(originalData: Data()))
    }
}
