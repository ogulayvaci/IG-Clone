//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 27.01.2025.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func singIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}
