//
//  StorageManager.swift
//  Instagram
//
//  Created by Андрей Худик on 13.02.23.
//

import FirebaseStorage
import Foundation

class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    enum IGStorageManageError: Error {
        case failedToDownload
    }
    
    public func uploadPost(model: UserPost, completion: @escaping (Result<URL, IGStorageManageError>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManageError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
                
            }
            completion(.success(url))
        }
    }
}
