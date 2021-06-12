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
        print(photo.image)
    }
    var photo: UIImage
    
    var capturedPhotoThumbnail: some View {
        Group {
            Image(uiImage: photo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .animation(.spring())
        }
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

struct PredictionPage_Previews: PreviewProvider {
    static var previews: some View {
        PredictionPage(photo: Photo(originalData: Data()))
    }
}
