//
//  Capitol.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/12/23.
//

import SwiftUI

struct Capitol: View {
    
    @State var goToRisk = false
    @State var user = User()
    
    var body: some View {
        VStack{
            Spacer()
            Text("What percent of your saving are you investing?")
                .fontWeight(.bold)
                .font(.title)
                .padding(.horizontal)
                .foregroundColor(royalBlueColor)
            Spacer()
            
        }
        
        Button(action: {
            goToRisk = true
        }) {
            Text("1-25")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Risk(user: user), isActive: $goToRisk) {
            EmptyView()
        }
        
        Button(action: {
            user.score += 1
            putWorker()
            goToRisk = true
        }) {
            Text("25-50")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Risk(user: user), isActive: $goToRisk) {
            EmptyView()
        }
        
        Button(action: {
            user.score += 2
            putWorker()
            goToRisk = true
        }) {
            Text("50-75")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Risk(user: user), isActive: $goToRisk) {
            EmptyView()
        }
        
        
        Button(action: {
            user.score += 4
            putWorker()
            goToRisk = true
        }) {
            Text("75-100")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Risk(user: user), isActive: $goToRisk) {
            EmptyView()
        }
        
        
    }
    
    
    func putWorker() {
        user.score += 2;

        
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode order")
            return
        }
        let resourceURL = "http://localhost:8080/api/user1/\(user.id)"
        let url = URL(string: resourceURL)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if (try? JSONDecoder().decode(User.self, from: data)) != nil {
                print("Succesfully Updated!")
            }
            else {
                print("Invalid response")
            }
            
        }.resume()
    }
    
    
}

struct Capitol_Previews: PreviewProvider {
    static var previews: some View {
        Capitol(user: User())
    }
}
