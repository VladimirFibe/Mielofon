import Foundation
import Firebase
import Combine

final class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticationFormValid = false
    @Published var user: User? = nil
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
    
    var isValidPassword: Bool {
        password.count > 5
    }
    
    func register() {
        AuthManager.shared.createUser(withEmail: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink {[weak self] result in
                if case .failure(let error) = result {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.createRecord(for: user)
            }
            .store(in: &subscriptions)
    }
    
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionPersons(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print(state)
            }
            .store(in: &subscriptions)
    }
    
    func login() {
        AuthManager.shared.signIn(withEmail: email, password: password)
            .sink {[weak self] result in
                if case .failure(let error) = result {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func validateAuthenticationForm() {
        isAuthenticationFormValid = isValidEmail && isValidPassword
    }
}
