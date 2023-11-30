//
//  LoginViewModel.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/16/23.
//

import Foundation
import Combine
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    // MARK: - Input
    @Published var email: String = ""
    @Published var password: String = ""

    // MARK: - Output
    @Published var isValid: Bool  = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String = ""
    @Published var user: User?
    
    // MARK: - Dependencies
    private var authenticationService: AuthenticationService?
    
    func connect(authenticationService: AuthenticationService) {
      if self.authenticationService == nil {
        self.authenticationService = authenticationService
        
        self.authenticationService?
          .$authenticationState
          .assign(to: &$authenticationState)
        
        self.authenticationService?
          .$errorMessage
          .assign(to: &$errorMessage)
        
        self.authenticationService?
          .$user
          .assign(to: &$user)
        
        Publishers.CombineLatest($email, $password)
          .map { !($0.isEmpty && $1.isEmpty) }
          .print()
          .assign(to: &$isValid)
      }
    }
    
    func signInWithEmailPassword() async -> Bool {
        print("signing in")
        if let authenticationService = authenticationService {
            print("calling authenitication service")
            return await authenticationService.signIn(withEmail: email, password: password)
        }
        else {
            print("failed to call authentication service")
            return false
        }
    }
}
