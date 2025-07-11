//
//  ContentView.swift
//  AspenTrip
//
//  Created by Amaan Hamza on 08/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("AspenBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 10) {
                    Text("Aspen")
                        .font(Font.custom("Hiatus", size: 128))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Plan your")
                        .font(Font.custom("Montserrat", size: 30))
                        .frame(maxWidth: 300, alignment: .topLeading)
                        .foregroundColor(.white)
                    Text("Luxurious\nVacation")
                        .font(Font.custom("Montserrat", size: 44))
                        .frame(maxWidth: 300, alignment: .topLeading)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    NavigationLink(destination: Lists().navigationBarBackButtonHidden(true)) {
                        Text("Explore")
                            .font(Font.custom("Montserrat", size: 20))
                            .bold()
                            .padding(.horizontal, 110)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
