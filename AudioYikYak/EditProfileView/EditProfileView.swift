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
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        VStack {
            if viewModel.user == nil {
                Text("No User Found")
            }
            else {
                Spacer()
                VStack(spacing: 20) {
                    Text("Username")
                    TextField("Username", text: .constant(viewModel.user?.displayName ?? "No Username"))
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.white)
                        .cornerRadius(UIValues.cornerRadius)
                        .padding(EdgeInsets(top: 0,
                                            leading: UIValues.sidePadding,
                                            bottom: 0,
                                            trailing: UIValues.sidePadding))
                    Text("Bio")
                    TextField("Bio", text: .constant(viewModel.user?.description ?? "Set your bio!"))
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.white)
                        .cornerRadius(UIValues.cornerRadius)
                        .padding(EdgeInsets(top: 0,
                                            leading: UIValues.sidePadding,
                                            bottom: 0,
                                            trailing: UIValues.sidePadding))
                    
                    //SLButton(title: "Submit", imageName: "arrow.right", isShowingModal: $isEditing)
                    Button {
                        Task { isEditing = false }
                    } label: {
                        Label("Save Changes", systemImage: "arrow.forward")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .controlSize(.large)
                }
                Spacer()
            }
        }
        .onAppear() {
            let currentUser = Auth.auth().currentUser
            if currentUser != nil {
                viewModel.user = currentUser
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

