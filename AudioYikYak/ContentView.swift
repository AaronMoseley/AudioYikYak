//
//  ContentView.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    /*@State private var usernameIn = ""
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
    }*/
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    //ContentView()
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
