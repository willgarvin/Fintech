//
//  User.swift
//  RoboAdviser
//
//  Created by Will Garvin on 1/16/23.
//
import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var email: String
    var password: String
    var score: Int

    
    
    init(id: UUID, name: String, email: String, password: String, score: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.score = score
    }
    
    init() {
        self.id = UUID()
        self.name = "Will Garvin"
        self.email = "will@gmail.com"
        self.password = "p"
        self.score = 0;
    }
    
}
