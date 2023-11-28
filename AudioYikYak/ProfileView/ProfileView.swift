//
//  ProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var user: User
    @State var isEditProfile = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Image(user.profilePicture)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            
            Text(user.username)
            Text(user.bio)
            
            Button {
                isEditProfile = true
            } label: {
                Text("Edit Profile")
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
        .background(UIValues.customBackground)

        .sheet(isPresented: $isEditProfile) {
            EditProfileView(isEditing: $isEditProfile)
        }
    }
}

#Preview {
    ProfileView(user: .constant(mockUser))
}

