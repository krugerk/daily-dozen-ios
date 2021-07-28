//
//  AboutSeparateView.swift
//  AboutSeparateView
//

import SwiftUI




struct AboutSeparateView: View {
    @Environment(\.colorScheme) var colorScheme
    //var myHeadingAndDetail: AboutData
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                
                VStack {Image("dr_greger")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                } //image
                .frame(width: 200, height: 200)
                Text("info_app_about_welcome")
                    .font(.title2)
                
                Text("info_app_about_overview2")
                    .font(.body)
                
            }//VStack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
            .padding()
            //  .border(Color.red, width: 4)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
           
            VStack(spacing: 20) {
                HStack {
                    Text("info_app_about_app_name")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .padding()
                    Text("info_app_about_version")
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                }
                Text("info_app_about_created_by2")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Text("info_app_about_oss_credits")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            
          
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
          
            
            //  .border(Color.red, width: 4)
             
        }//VStack
    }
}

struct AboutSeparateView2_Previews: PreviewProvider {
    static var previews: some View {
        AboutSeparateView()
//        ForEach(ColorScheme.allCases, id: \.self) {
//            AboutSeparateView2().preferredColorScheme($0)
 //       }
        
    }
}
