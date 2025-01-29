//
//  User.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Codable , Hashable{
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullName: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currenUid = Auth.auth().currentUser?.uid else { return false }
        return currenUid == id
    }
}
extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: nil, fullName: "", bio: "I'm Batman!", email: "bruce@example.com"),
        .init(id: NSUUID().uuidString, username: "spiderman", profileImageUrl: nil, fullName: "Peter Parker", bio: "With great power comes great responsibility!", email: "peter@example.com"),
        .init(id: NSUUID().uuidString, username: "blackpanther", profileImageUrl: nil, fullName: "King T'Challa", bio: "Wakanda Forever!", email: "king@example.com"),
        .init(id: NSUUID().uuidString, username: "ironman", profileImageUrl: nil, fullName: "Tony Stark", bio: "I'm Iron Man!", email: "tony@example.com"),
        .init(id: NSUUID().uuidString, username: "venom", profileImageUrl: nil, fullName: "Eddie Brock", bio: "Not your average Spider-Man!", email: "eddie@example.com")
    ]
}
