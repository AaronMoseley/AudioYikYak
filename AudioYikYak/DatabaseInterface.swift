//
//  DatabaseInterface.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
    
func getUsers() async -> Array<String> {
    let db = Firestore.firestore()
    var users: [String] = []
    
    do {
        let collRef = try await db.collection("users").getDocuments()
        for snapshot in collRef.documents {
            users.append(snapshot.documentID)
        }
        
        return users
    } catch {
        print("Error getting documents")
        return []
    }
}

func checkPassword(username: String, inputPassword: String) async -> Bool
{
    let db = Firestore.firestore()
    do {
        let doc = try await db.collection("users").document(username).getDocument()
        let realPass = doc["password"]
        
        return realPass as! String == inputPassword
    } catch {
        print("Error checking password")
        return false
    }
}

func checkIfUsernameExists(username: String) async -> Bool {
    let db = Firestore.firestore()
    
    do {
        let doc = try await db.collection("users").document(username).getDocument()
        
        if doc.exists { return true }
        return false
    } catch {
        print("Error checking username")
        return false
    }
}

func addUser(user: User)
{
    let db = Firestore.firestore()
    let userDB = db.collection("users")
    
    userDB.document(user.username).setData([
        "password": user.password,
        "bio": user.bio
    ])
}

func addUser(username: String, password: String, bio: String) {
    let db = Firestore.firestore()
    let userDB = db.collection("users")
    
    userDB.document(username).setData([
        "password": password,
        "bio": bio
    ])
}
