//
//  PostService.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 29.01.2025.
//

import Foundation
import Firebase

struct PostService {
    
    static private let postColletcion = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws-> [Post] {
        let snapshot = try await postColletcion.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
        
        for i in 0..<posts.count{
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    
    // searches the uid in users and gets their data to show
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postColletcion.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
        
    }
}
