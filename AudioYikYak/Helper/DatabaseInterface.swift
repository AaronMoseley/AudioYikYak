//
//  DatabaseInterface.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

func uploadAudioFile(username: String, currentFileName: URL) async {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let fileRef = storageRef.child(username + "-" + String(NSDate().timeIntervalSince1970) + ".m4a")
    
    let metadata = StorageMetadata()
    metadata.customMetadata = ["username": username]
    
    let uploadTask = fileRef.putFile(from: currentFileName, metadata: metadata) { metadata, error in
        guard metadata == metadata else {
            print("Error uploading file")
            return
        }
    }
    
    uploadTask.observe(.success) { snapshot in
        print("Uploaded successfully")
    }
    
    uploadTask.observe(.failure) { snapshot in
        if let error = snapshot.error as? NSError {
            switch (StorageErrorCode(rawValue: error.code)!) {
            case .objectNotFound:
                print("File doesn't exist")
                break
            case .unauthorized:
                print("Unauthorized")
                break
            case .cancelled:
                print("Cancelled")
                break
            case .unknown:
                print("Unknown error")
                break
            default:
                print("Retry upload")
                break
            }
        }
    }
}

func getAudioFileName(index: Int) async -> String {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    
    var fileName = ""
    
    do {
        let fileNames = try await storageRef.listAll().items
        if fileNames.count <= index {
            return ""
        } else {
            fileName = fileNames[index].name
        }
    } catch {
        return ""
    }
    
    return fileName
}

func getNumberOfAudioFiles() async -> Int {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    
    do {
        let fileNames = try await storageRef.listAll().items
        return fileNames.count
    } catch {
        return -1
    }
}

func downloadAudioFile(completion: @escaping (Bool) -> Void, index: Int, outputDirectory: URL) async -> String {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    
    var fileName = ""
    
    do {
        let fileNames = try await storageRef.listAll().items
        if fileNames.count <= index {
            return ""
        } else {
            fileName = fileNames[index].name
        }
    } catch {
        return ""
    }
    
    let fileRef = storageRef.child(fileName)
    
    var username = ""
    
    do {
        let meta = try await fileRef.getMetadata()
        username = meta.customMetadata?["username"] ?? ""
    } catch {
        return ""
    }
    
    if username == "" {
        return ""
    }
    
    let localURL = outputDirectory.appendingPathComponent(fileName)
    
    let downloadTask = fileRef.write(toFile: localURL) { url, error in
        if error != nil {
            print("Error has occured while downloading file")
        }
    }
    
    downloadTask.observe(.success) { snapshot in
        completion(true)
        downloadTask.removeAllObservers()
    }
    
    downloadTask.observe(.failure) { snapshot in
      guard let errorCode = (snapshot.error as? NSError)?.code else {
        return
      }
      guard let error = StorageErrorCode(rawValue: errorCode) else {
        return
      }
      switch (error) {
      case .objectNotFound:
        print("File does not exist")
        break
      case .unauthorized:
        print("Unauthorized to access the file")
        break
      case .cancelled:
        print("Download cancelled")
        break
      case .unknown:
        print("Unknown error occured")
        break
      default:
        print("Other error occured")
        break
      }
    }
    
    return username
}

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

func getUsername(user: User) async -> String
{
    let db = Firestore.firestore()
    do {
        let doc = try await db.collection("users").document(user.uid).getDocument()
        let username = doc["username"]
        return username as! String
    } catch {
        print("Error getting username")
        return ""
    }
}

func getBio(user: User) async -> String
{
    let db = Firestore.firestore()
    do {
        let doc = try await db.collection("users").document(user.uid).getDocument()
        let bio = doc["bio"]
        
        return bio as! String
    } catch {
        print("Error getting bio")
        return ""
    }
}

func checkIfUsernameExists(user: User) async -> Bool {
    let db = Firestore.firestore()
    
    do {
        let doc = try await db.collection("users").document(user.uid).getDocument()
        if doc.exists { return true }
        return false
    } catch {
        print("Error checking username")
        return false
    }
}

func changeUserData(user: User, username: String, bio: String)
{
    let db = Firestore.firestore()
    let userDB = db.collection("users")
    
    userDB.document(user.uid).setData([
        "username": username,
        "bio": bio
    ])
}

func addUser(user: User, username: String) {
    let db = Firestore.firestore()
    let userDB = db.collection("users")
    userDB.document(user.uid).setData([
        "username": username,
        "bio": ""
    ])
}
