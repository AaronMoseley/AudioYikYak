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
    
    func signUp (username: String, password: String) async {
        let usernameExists = await checkIfUsernameExists(username: username)
        
        if usernameExists {
            self.errorMessage = "User already exists"
            return
        }
        
        addUser(username: username, password: password, bio: "")
        
        shouldShowSignUpView = false
        isLoggedIn = true
    }
}
