import Foundation
import Combine
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    @Published var person: Person?
    @Published var error: String?
    @Published var tweets: [Tweet] = []
    private var subscriptions: Set<AnyCancellable> = []
    
    func fetchPerson() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionPersons(retreive: id)
            .handleEvents(receiveOutput: {[weak self] _ in self?.fetchTweets()})
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] person in
                self?.person = person
            }
            .store(in: &subscriptions)
    }
    
    func fetchTweets() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionTweets(retreiveTweets: uid)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] tweets in
                self?.tweets = tweets
            }
            .store(in: &subscriptions)

    }
}
