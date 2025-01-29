//
//  EditProfileViewModel.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 27.01.2025.
//

import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        
        didSet { Task {await loadImage(fromItem: selectedImage)} }
    }
    
    @Published var profileImage: Image?
    
    @Published var fullname: String = ""
    @Published var bio: String = ""
    
    private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
        
        if let fullName = user.fullName {
            self.fullname = fullName
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        
        // check if we have the item, due to its 'optional' state
        guard let item = item else { return }
        
        // get the image data, and create & set the uiImage
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserDate() async throws{
        // update pp if changed
        
        var data = [String:Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl 
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullName != fullname{
            data["fullName"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio{
            data["bio"] = bio
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
}
