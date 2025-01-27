//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 27.01.2025.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task{ try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws{
        self.users = try await UserService.fetchAllUsers()
    }
}
