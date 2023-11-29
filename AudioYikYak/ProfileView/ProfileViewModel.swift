//
//  ProfileViewModel.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/29/23.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var user: User?
}
