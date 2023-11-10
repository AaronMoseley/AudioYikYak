//
//  ContentView.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""
    
    var body: some View {
        VStack {
            Button(action: {
                //Task { await testGetUsernames() }
                //testAddUser()
                //Task { await testCheckPassword() }
                Task { await testCheckIfUsernameExists() }
            }, label: {
                Text("Test")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            )
            
            Text("Output: \(output)")
        }
        .padding()
    }
    
    func testAddUser () {
        self.output = "going"
        
        addUser(username: "testUsername", password: "asdfg", bio: "Another test bio")
        
        self.output += "gone"
    }
    
    func testGetUsernames () async {
        self.output = "going"
        
        let users = await getUsers()
        for user in users {
            self.output += user + " "
        }
        
        self.output += "gone"
    }
    
    func testCheckPassword() async {
        self.output = "going"
        
        let result = await checkPassword(username: "aaronmoseley", inputPassword: "125")
        self.output += String(result)
        
        self.output += "gone"
    }
    
    func testCheckIfUsernameExists() async {
        self.output = "going"
        
        let result = await checkIfUsernameExists(username: "aaronmoseley")
        self.output += String(result)
        
        self.output += "gone"
    }
}

#Preview {
    ContentView()
}
