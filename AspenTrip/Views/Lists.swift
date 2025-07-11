//
//  SwiftUIView.swift
//  AspenTrip
//
//  Created by Amaan Hamza on 09/07/2025.
//

import SwiftUI



struct Location : Decodable, Hashable {
    let id: Int
    let name: String
    let imageURL: String
    let rating: Double
    //let liked: Bool
}

class LocationListViewModel: ObservableObject {
    @Published var locs : [Location] = []
    
    func fetchLandmarks() {
        let url = URL(string: "http:localhost:3001/landmarks")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("aspen", forHTTPHeaderField: "location")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //print(data.map { String(format: "%02x", $0) }.joined())
                let decodedData = try JSONDecoder().decode([Location].self, from: data)
                
                DispatchQueue.main.async {
                    self.locs = decodedData
                }
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
}

struct displayLocation : View {
    var name : String
    
    init (name: String) {
        self.name = name
    }
    var body : some View {
        //Image("AspenBG")
        //    .resizable()
        //    .aspectRatio(contentMode: .fill)
        //    .edgesIgnoringSafeArea(.all)
        //    .cornerRadius(20)
        Text(self.name)
    }
}

struct Lists: View {
    @StateObject var locationListViewModel = LocationListViewModel()
    
    let tabs = ["Location", "Hotels", "Food", "Adventure", "Nightlife", "Beach", ]
    @State var selectedIndex = 0
    var body: some View {
        VStack() {
            HStack {
                VStack {
                    Text("Explore")
                        .font(Font.custom("Montserrat", size: 20))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    Text("Aspen")
                        .font(Font.custom("Montserrat", size: 34))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .fontWeight(.medium)
                }.padding()
                Spacer()
                HStack {
                    Image("location-1")
                    Text("Aspen, USA")
                        .font(Font.custom("Montserrat", size: 16))
                    Image("adown2")
                }.padding()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabs.indices, id: \.self) { tabIndex in
                        let isSelected = tabIndex == selectedIndex;
                        Text(tabs[tabIndex])
                            .font(Font.custom("Montserrat", size: 16))
                            .fontWeight(
                                isSelected ? .semibold : .regular
                            )
                            .foregroundColor(
                                isSelected ? .blue : .gray
                            )
                            .padding(
                                isSelected ? 15 : 10
                            )
                            .background(Capsule()
                                .foregroundColor(
                                    isSelected ? .blue : .gray
                                )
                                    .opacity(0.1)
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.09)) {
                                    selectedIndex = tabIndex
                                }
                            }
                    }
                }
            }
            .padding(.vertical, 1)
            .padding(.horizontal)
            .cornerRadius(25)
            Text("Explore")
                .font(Font.custom("Montserrat", size: 30))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(locationListViewModel.locs, id: \.self) { loc in
                        displayLocation(name: loc.name)
                            .frame(maxWidth: 200, maxHeight: 200)
                    }
                }
                .padding(.vertical, 1)
                .padding(.horizontal)
            }
            Spacer()
        }
        .onAppear {
            locationListViewModel.fetchLandmarks()
        }
    }
}

#Preview {
    Lists()
}
