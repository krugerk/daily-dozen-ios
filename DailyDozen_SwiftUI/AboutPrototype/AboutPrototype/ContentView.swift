//
//  ContentView.swift
//  AboutPrototype
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
      AboutScrollView()
            .padding()
           
        //comment out for watch
           .background(Color("LtGrayBkgroundColor"))
        

            
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
