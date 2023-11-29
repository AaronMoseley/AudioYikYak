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
    
    func checkCanLogIn(username: String, password: String) async -> Array<String> {
        if username == "" || password == "" {
            self.errorMessage = "Cannot have empty username or password"
            return [String]()
        }
        
        let usernameResult = await checkIfUsernameExists(username: username)
        
        if !usernameResult {
            self.errorMessage = "User does not exist"
            return [String]()
        }
        
        let passwordResult = await checkPassword(username: username, inputPassword: password)
        
        if !passwordResult {
            self.errorMessage = "Incorrect password"
            return [String]()
        } else {
            self.shouldShowLoginView = false
            self.isLoggedIn = true
            
            var result = [String]()
            result.append(username)
            result.append(password)
            result.append(await getBio(username: username))
            return result
        }
    }
}
