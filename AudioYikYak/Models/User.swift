//
//  User.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import Foundation

struct User {
    var profilePicture = "profile-image"
    var username: String
    var password: String
    var bio: String
}


let mockUser = User(username: "myusername", password: "mypassword", bio: "this is my bio")
