//
//  AuthService.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 27.01.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: withEmail, password: password)
            self.userSession = result.user
            
        } catch {
            print("Debug: failed to login user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("Debug: did create user")
            
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
            print("Debug: did successfully register user")
            
        } catch {
            print("Debug: failed to register user with error: \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws {
        
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async{
        let user = User(id: uid, username: username, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
