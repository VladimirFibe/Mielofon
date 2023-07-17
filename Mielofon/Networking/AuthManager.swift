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
    
    func signIn(withEmail email: String, password: String) -> AnyPublisher<User, Error> {
        Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {}
    }
}
