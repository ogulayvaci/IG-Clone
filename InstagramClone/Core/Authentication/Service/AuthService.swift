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
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task{ try await loadUserData()}
    }
    
    @MainActor
    func login(withEmail: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: withEmail, password: password)
            self.userSession = result.user
            
            // call this everytime user loged in cos the data needs to be refreshed along with the current user
            try await loadUserData()
        } catch {
            print("Debug: failed to login user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
            
        } catch {
            print("Debug: failed to register user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        
        guard let currentUid = userSession?.uid else { return }
        
        //snapshot holds the information of "users" collection's currentUid row.
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async{
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
