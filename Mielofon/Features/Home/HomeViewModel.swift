import Foundation
import Combine
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    @Published var person: Person?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func retrivePerson() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionPersons(retreive: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] person in
                self?.person = person
            }
            .store(in: &subscriptions)

    }
}
