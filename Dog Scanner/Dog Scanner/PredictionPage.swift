//
//  PredictionPage.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 10.06.21.
//

import SwiftUI

struct PredictionPage: View {
    init(photo: Photo) {
        self.photo = photo
        print(photo.compressedData)
    }
    var photo: Photo
    
    var capturedPhotoThumbnail: some View {
        Group {
            if photo != nil {
                Image(uiImage: photo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .animation(.spring())
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    
            }
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
