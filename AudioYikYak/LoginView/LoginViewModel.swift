//
//  LoginViewModel.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/16/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var shouldShowLoginView: Bool = true
    
    func checkCanLogIn(username: String, password: String, isShowingLoginView: Bool) async {
        let usernameResult = await checkIfUsernameExists(username: username)
        
        if !usernameResult {
            self.errorMessage = "User does not exist"
            return
        }
        
        let passwordResult = await checkPassword(username: username, inputPassword: password)
        
        if !passwordResult {
            self.errorMessage = "Incorrect password"
        } else {
            shouldShowLoginView = false
            self.isLoggedIn = true
        }
    }
}
