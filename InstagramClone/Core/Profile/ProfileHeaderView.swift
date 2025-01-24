//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Ogul Ayvaci on 24.01.2025.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    
    var body: some View {
        // header
        VStack(spacing: 10){
            
            // pic and follow
            HStack{
                Image(user.profileImageUrl ?? "")
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
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[1])
}
