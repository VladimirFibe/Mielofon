import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

final class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    
    let db = Firestore.firestore()
    let personPath = "persons"
    
    func collectionPersons(add user: User) -> AnyPublisher<Bool, Error> {
        let person = Person(from: user)
        return db.collection(personPath)
            .document(person.id)
            .setData(from: person)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    func collectionPersons(retreive id: String) -> AnyPublisher<Person, Error> {
        db.collection(personPath)
            .document(id)
            .getDocument()
            .tryMap { try $0.data(as: Person.self) }
            .eraseToAnyPublisher()
    }
    
    func collectionPersons(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(personPath).document(id).updateData(updateFields)
            .map { _ in true}
            .eraseToAnyPublisher()
    }
}
