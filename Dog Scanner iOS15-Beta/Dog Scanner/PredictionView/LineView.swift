//
//  LineView.swift
//  Dog Scanner
//
//  Created by Michael Spilger on 16.06.21.
//

import SwiftUI

struct LineView: View {
    init(label: String, probability: Float) {
        prb = String(format: "%.2f", probability)
        lbl = label.components(separatedBy: "-")[1].replacingOccurrences(of: "_", with: " ")
        print(lbl)
    }
    var lbl: String
    var  prb: String
    var body: some View {
        VStack {
            Text(lbl + " " + prb).padding().font(.title3)
        }.frame(width: UIScreen.screenWidth * 0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color("Background"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(label: "Labrador", probability: 0.9)
    }
}
