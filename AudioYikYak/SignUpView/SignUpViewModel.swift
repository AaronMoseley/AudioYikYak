//
//  SignUpViewModel.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/16/23.
//

import Foundation


class SignUpViewModel: ObservableObject {
    
    @Published var shouldShowSignUpView: Bool = true
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    func signUp (username: String, password: String) async -> Bool {
        let usernameExists = await checkIfUsernameExists(username: username)
        
        if usernameExists {
            self.errorMessage = "User already exists"
            return false
        }
        
        addUser(username: username, password: password, bio: "Add a bio about yourself!")
        
        shouldShowSignUpView = false
        isLoggedIn = true
        return true
    }
}
