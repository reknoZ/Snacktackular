//
//  LoginView.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//
//	Source: www.youtube.com/watch?v=PxAchicsUYY
//	Source: bit.ly/prof-g-swiftui-files

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Image("snack-icon")
				.resizable()
				.scaledToFit()
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
