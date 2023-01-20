//
//  Conclusion.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/16/23.
//

import SwiftUI

struct Conclusion: View {
    
    @State var user = User()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Your risk score is:")
                .fontWeight(.bold)
                .font(.title)
                .padding(.horizontal)
                .foregroundColor(royalBlueColor)
            Spacer()
            
            Text("\(user.score)")
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

struct Conclusion_Previews: PreviewProvider {
    static var previews: some View {
        Conclusion(user: User())
    }
}
