//
//  Age.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/12/23.
//

import SwiftUI

struct Age: View {
    
    @State var goToCapitol = false
    @State var user = User()
    
    var body: some View {
        
        
        VStack{
            //Spacer()
            Text("What is your age?")
                .fontWeight(.bold)
                .font(.title)
                .padding(.horizontal)
                .foregroundColor(royalBlueColor)
            Spacer()
            
            
        }
        
        
        Button(action: {
            goToCapitol = true
        }) {
            Text("18-24")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Capitol(), isActive: $goToCapitol) {
            EmptyView()
        }
        Button(action: {
            user.score += 1
            putWorker()
            goToCapitol = true
        }) {
            Text("25-40")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Capitol(), isActive: $goToCapitol) {
            EmptyView()
        }
        Button(action: {
            user.score += 2
            putWorker()
            goToCapitol = true
        }) {
            Text("40+")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Capitol(), isActive: $goToCapitol) {
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

struct Age_Previews: PreviewProvider {
    static var previews: some View {
        Age(user: User())
    }
}
