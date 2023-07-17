import Foundation
import Firebase
import Combine

final class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticationFormValid = false
    @Published var user: User? = nil
    private var subscriptions: Set<AnyCancellable> = []
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
    
    var isValidPassword: Bool {
        password.count > 5
    }
    
    func register() {
        AuthManager.shared.createUser(withEmail: email, password: password)
            .sink { _ in } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func login() {
        AuthManager.shared.signIn(withEmail: email, password: password)
            .sink { _ in } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func validateAuthenticationForm() {
        isAuthenticationFormValid = isValidEmail && isValidPassword
    }
}
