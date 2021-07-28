//
//  AboutSeparateView2.swift
//  AboutSeparateView2
//

import SwiftUI

struct AboutSeparateView3: View {
    //@Environment(\.colorScheme) var colorScheme
    
    var body: some View {
       // ScrollView {
        VStack(spacing: 20) {
            
            VStack {Image("dr_greger")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            } //image
            .frame(width: 80, height: 80)
            Text("info_app_about_welcome")
                .font(.headline)
            
            Text("info_app_about_overview2")
                .font(.body)
            
        }//VStack
       // .background(colorScheme == .dark ? Color.black : Color.white)
   // }
    }
}

struct AboutSeparateView3_Previews: PreviewProvider {
    static var previews: some View {
        AboutSeparateView3()
    }
}


