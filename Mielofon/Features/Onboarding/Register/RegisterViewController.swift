import UIKit
import FirebaseAuth
import Combine

class RegisterViewController: UIViewController {

    private var viewModel = RegisterViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let registerTitleLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Action
extension RegisterViewController {
    @objc private func didTapRegisterButton() {
        viewModel.register()
    }
    
    @objc private func didChangeEmailField() {
        if let email = emailTextField.text {
            viewModel.email = email
            viewModel.validateAuthenticationForm()
        }
    }
    
    @objc private func didChangePasswordField() {
        if let password = passwordTextField.text {
            viewModel.password = password
            viewModel.validateAuthenticationForm()
        }
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
}
// MARK: - Setup Views
extension RegisterViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        viewModel.$isAuthenticationFormValid
            .sink { [weak self] value in self?.registerButton.isEnabled = value }
            .store(in: &subscriptions)
                
        setupRegisterTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupRegisterButton()
    }
    
    private func setupRegisterTitleLabel() {
        view.addSubview(registerTitleLabel)
        registerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        registerTitleLabel.text = "Create your account"
        registerTitleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        NSLayoutConstraint.activate([
            registerTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            registerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalToSystemSpacingBelow: registerTitleLabel.bottomAnchor, multiplier: 2),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: emailTextField.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: emailTextField.bottomAnchor, multiplier: 1),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.isEnabled = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Create account", for: [])
        registerButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 2),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
