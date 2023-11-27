//
//  EditProfileView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/21/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isEditing)
            Spacer()
            VStack(spacing: 20) {
                Text("Username")
                TextField("Username", text: .constant(mockUser.username))
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                Text("Bio")
                TextField("Bio", text: .constant(mockUser.bio))
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                
                SLButton(title: "Submit", imageName: "arrow.right", isShowingModal: $isEditing)
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

#Preview {
    EditProfileView(isEditing: .constant(true))
}
