//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    @State private var showEditProfile: Bool = false
    
    var body: some View {
        // header
        VStack(spacing: 10){
            
            // pic and follow
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    UserStatView(value: 13, title: "Posts")
                    
                    UserStatView(value: 300, title: "Followers")
                    
                    UserStatView(value: 162, title: "Following")
                }
            }
            .padding(.horizontal)
            
            
            // name bio
            VStack(alignment: .leading, spacing: 4){
                if let fullname = user.fullName{
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio{
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            // action button
            Button {
                if user.isCurrentUser{
                    showEditProfile.toggle()
                    print("toggled edit profile")
                } else {
                    print("follow user")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .blue : .white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1))
            }
            
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[1])
}
