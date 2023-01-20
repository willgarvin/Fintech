//
//  Risk.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/16/23.
//

import SwiftUI

struct Risk: View {
    
    @State var goToSummary = false
    @State var user = User()
    
    var body: some View {
        VStack{
            Spacer()
            Text("What would you do if your portfolio dropped in value by 15%")
                .fontWeight(.bold)
                .font(.title)
                .padding(.horizontal)
                .foregroundColor(royalBlueColor)
            Spacer()
            
        }
        
        Button(action: {
            goToSummary = true
        }) {
            Text("Sell all the assets in my portfolio")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Conclusion(user: user), isActive: $goToSummary) {
            EmptyView()
        }
        
        Button(action: {
            user.score += 1
            putWorker()
            goToSummary = true
        }) {
            Text("Sell some of the assets in my portfolio")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Conclusion(user: user), isActive: $goToSummary) {
            EmptyView()
        }
        
        Button(action: {
            user.score += 2
            putWorker()
            goToSummary = true
        }) {
            Text("Do nothing")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Conclusion(user: user), isActive: $goToSummary) {
            EmptyView()
        }
        
        
        Button(action: {
            user.score += 4
            putWorker()
            goToSummary = true
        }) {
            Text("Buy more assets")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }.padding()
        NavigationLink(destination: Conclusion(user: user), isActive: $goToSummary) {
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

struct Risk_Previews: PreviewProvider {
    static var previews: some View {
        Risk(user: User())
    }
}
