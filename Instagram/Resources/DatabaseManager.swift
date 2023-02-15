//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Андрей Худик on 13.02.23.
//

import FirebaseDatabase


public class DatabaseManager {
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    
    /// Check if username and email are avaliable
    /// - Parameters:
    ///  - email: String represanting email
    ///  - password: String represanting password
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert new user data to database
    /// - Parameters:
    ///  - email: String represanting email
    ///  - password: String represanting password
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(username).setValue(["email": email]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
