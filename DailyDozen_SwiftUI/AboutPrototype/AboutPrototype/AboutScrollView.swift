//
//  ScrollView.swift
//  ScrollView
//

import SwiftUI

struct AboutScrollView: View {
    var body: some View {
        VStack {
            //Comment out for watchOS
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFill()
            } .frame(width: 200, height: 100)
            
            ScrollView {
                AboutSeparateView()
            }
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AboutScrollView()
    }
}
