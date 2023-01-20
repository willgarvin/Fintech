//
//  ContentView.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/12/23.
//

import SwiftUI

let royalBlueColor = Color(red: 29.0/255.0, green: 73.0/255.0, blue: 153.0/255.0, opacity: 1.0)

struct ContentView: View {
    
    
    @State var moveOn = false
    @State var user = User()
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    
                    //Spacer()
                    
                    Text("Michigan Advising Project")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.horizontal)
                        .foregroundColor(royalBlueColor)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                    //.clipShape(Circle())
                        .padding()
                    
                    
                    
                    Spacer()
                    
                    
                }
                Spacer()
                
                
                Button(action: {
                    moveOn = true
                }) {
                    Text("START INVESTING")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                NavigationLink(destination: Age(user: user), isActive: $moveOn) {
                    EmptyView()
                }
                
                
                Spacer()
            }.onAppear(perform: loadWorkerData)
            .padding()
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    
    
    //TODO: Update userID once sign up form is finished
    func loadWorkerData() {
            guard let url = URL(string: "http://localhost:8080/api/user1/4E793A14-E1F0-445A-A509-CBDF487B42B5") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(User.self, from: data) {
                        DispatchQueue.main.async {
                            self.user = response
                           
                        }
                        return
                    }
                }
            }.resume()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
