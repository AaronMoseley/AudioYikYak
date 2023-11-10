//
//  ContentView.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usernameIn = ""
    @State private var passwordIn = ""
    
    @State private var usernameList = ""
    @State private var correctPassword = ""
    
    
    var body: some View {
        VStack {
            TextField("Username: ", text: $usernameIn)
            TextField("Password: ", text: $passwordIn)
            
            Button(action: {
                testAddUser()
            }, label: {
                Text("Add User")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            })
            
            Button(action: {
                Task { await testGetUsernames() }
            }, label: {
                Text("List All Usernames")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            })
            Text("Usernames: \(usernameList)")
            
            Button(action: {
                Task { await testCheckPassword() }
            }, label: {
                Text("Check Password")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            })
            
            Text("Correct Password: \(correctPassword)")
        }
        .padding()
    }
    
    func testAddUser () {
        addUser(username: self.usernameIn, password: self.passwordIn, bio: "Another test bio")
        
        self.usernameIn = ""
        self.passwordIn = ""
    }
    
    func testGetUsernames () async {
        usernameList = ""
        
        let users = await getUsers()
        
        for user in users {
            usernameList += user + " "
        }
    }
    
    func testCheckPassword() async {
        let accountExists = await checkIfUsernameExists(username: self.usernameIn)
        
        if !accountExists {
            self.correctPassword = "Account does not exist"
        } else {
            let result = await checkPassword(username: self.usernameIn, inputPassword: self.passwordIn)
            self.correctPassword = String(result)
        }
    }
}

#Preview {
    ContentView()
}
