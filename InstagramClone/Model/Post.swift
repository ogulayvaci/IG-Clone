//
//  Post.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    var id: String
    var ownerUid: String
    var caption: String
    var likes: Int
    var imageUrl: String
    var timeStamp: Date
    var user: User?
}


extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "this is the some test caption for now",
              likes: 1234,
              imageUrl: "batman-2",
              timeStamp: Date(),
              user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "venom booyyyy",
              likes: 4985,
              imageUrl: "venom-3",
              timeStamp: Date(),
              user: User.MOCK_USERS[2]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "neighbor h00d",
              likes: 99,
              imageUrl: "spiderman-2",
              timeStamp: Date(),
              user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "where's mj",
              likes: 13,
              imageUrl: "spiderman-3",
              timeStamp: Date(),
              user: User.MOCK_USERS[3]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "happy looks happy, lol",
              likes: 66,
              imageUrl: "ironman",
              timeStamp: Date(),
              user: User.MOCK_USERS[3])
    ]
}
