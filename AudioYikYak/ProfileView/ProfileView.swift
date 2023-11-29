//
//  ProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @State var isEditProfile: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Image("profile-image")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            
            Text("tmpusername")
            
            Text("This is my bio!")
            
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
    }
}

