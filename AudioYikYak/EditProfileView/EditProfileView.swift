//
//  EditProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI
import FirebaseAuth

struct EditProfileView: View {
    
    @Binding var isEditing: Bool
    @Binding var currUser: CustomUser
    
    func makeChanges() {
        if let currentUser = Auth.auth().currentUser {
            changeUserData(user: currentUser, username: currUser.username, bio: currUser.bio)
            isEditing = false
        }
    }
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isEditing)
            Spacer()
            VStack(spacing: 20) {
                Text("Username")
                TextField("Username", text: $currUser.username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                Text("Bio")
                TextField("Bio", text: $currUser.bio)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                
                Button {
                    Task { makeChanges() }
                } label: {
                    Label("Save Changes", systemImage: "arrow.forward")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
            }
            Spacer()
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

