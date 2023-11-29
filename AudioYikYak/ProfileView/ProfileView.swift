//
//  ProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State var isEditProfile: Bool = false
    @Binding var currUser: CustomUser
    
    var body: some View {
        VStack(spacing: 30) {
            if (viewModel.user == nil) {
                Text("No user found")
            }
            else {
                Image("profile-image")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Text(currUser.username)
                
                Text(currUser.bio)
                
                Button {
                    isEditProfile = true
                } label: {
                    Text("Edit Profile")
                }
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

