//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 29.01.2025.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws{
        self.posts = try await PostService.fetchFeedPosts()
    }
}
