//
//  EditProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @Binding var isEditing: Bool
    @State private var newBio: String
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isEditing)
            Spacer()
            VStack(spacing: 20) {
                Text("Username")
                Text("tmpusername")
                Text("Bio")
                TextField("Bio", text: $newBio)
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                
                //SLButton(title: "Submit", imageName: "arrow.right", isShowingModal: $isEditing)
                Button {
                    Task { /* makeChanges() */ }
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
    
//    init(newuser: binding<user>, editing: binding<bool>) {
//        _newbio = state(initialvalue: newuser.bio.wrappedvalue)
//        _isediting = editing
//        _user = newuser
//    }
//    
//    func makechanges () {
//        self.isediting = false
//        self.user.bio = self.newbio
//        changeuserdata(user: self.user)
//    }
}

