import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticationFormValid = false
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
    
    var isValidPassword: Bool {
        password.count > 5
    }
    
    func register() {
        print(isValidEmail)
    }
    
    func validateAuthenticationForm() {
        isAuthenticationFormValid = isValidEmail && isValidPassword
    }
}
