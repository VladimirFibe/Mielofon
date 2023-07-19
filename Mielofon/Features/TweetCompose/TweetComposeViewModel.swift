import Foundation
import Combine
import FirebaseAuth

final class TweetComposeViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    @Published var isValidToTweet = false
    @Published var error = ""
    @Published var shouldDismissCompose = false
    var tweetContent = ""
    private var person: Person?
    
    func getPerson() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionPersons(retreive: uid)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] person in
                self?.person = person
            }
            .store(in: &subscriptions)
    }
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
    
    func dispatchTweet() {
        guard let person else { return }
        let tweet = Tweet(person: person, uid: person.id, content: tweetContent, likes: 0, likers: [], isReply: false, parent: nil)
        DatabaseManager.shared.collectionTweets(dispatch: tweet)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: {[weak self] state in
                self?.shouldDismissCompose = state
            }
            .store(in: &subscriptions)
    }
}
