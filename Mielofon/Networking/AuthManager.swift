//
//  AuthManager.swift
//  Mielofon
//
//  Created by Vladimir Fibe on 17.07.2023.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    func createUser(withEmail email: String, password: String) -> AnyPublisher<User, Error> {
        Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
