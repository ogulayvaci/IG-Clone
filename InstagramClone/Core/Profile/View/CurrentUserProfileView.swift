//
//  CurrentUserProfileView.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    @State private var showEditProfile: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
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
                        Text(user.fullName ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(user.bio ?? "")
                            .font(.footnote)
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
                        Text("Edit profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 360, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1))
                    }
                    
                    
                    Divider()
                }
                
                
                // post grid view
                PostGridView(user: user)
            }
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
