//
//  StartButton.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct SLButton: View {
    
    let title: String
    let imageName: String
    @Binding var isShowingModal: Bool
    
    var body: some View {
        Button {
            isShowingModal = !isShowingModal
            print("TAPPED")
        } label: {
            Label(title, systemImage: imageName)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .controlSize(.large)
    }
}

