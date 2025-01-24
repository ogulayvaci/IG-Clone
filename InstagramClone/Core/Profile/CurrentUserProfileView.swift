//
//  CurrentUserProfileView.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({$0.user?.username == user.username})
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                // header
                VStack(spacing: 10){
                    
                    // pic and follow
                    HStack{
                        Image("blackpanther")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
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
                        Text("Chadwick Boseman")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text("Wakanda Forever")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
                    // action button
                    Button {
                        
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
                PostGridView(posts: posts)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
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
