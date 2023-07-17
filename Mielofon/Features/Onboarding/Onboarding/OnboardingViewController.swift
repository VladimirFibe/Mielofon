import UIKit

class OnboardingViewController: UIViewController {

    private let welcomeLabel = UILabel()
    private let createAccountButton = UIButton(type: .system)
    private let promptLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Action
extension OnboardingViewController {
    @objc private func didTapRegisterButton() {
        let controller = AuthenticationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func didTapLoginButton() {
        let controller = AuthenticationViewController()
        controller.isLogin = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Setup Views
extension OnboardingViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Onboarding"
        setupWelcomeLabel()
        setupCreateAccountButton()
        setupPromptLabel()
        setupLoginButton()
    }
    
    private func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "See what's happening in the world right now."
        welcomeLabel.numberOfLines = 0
        welcomeLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        welcomeLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            welcomeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: welcomeLabel.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupCreateAccountButton() {
        view.addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.setTitle("Create account", for: [])
        createAccountButton.addTarget(self, action: #selector(didTapRegisterButton), for: .primaryActionTriggered)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalToSystemSpacingBelow: welcomeLabel.bottomAnchor, multiplier: 2),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.text = "Have an account already?"
        promptLabel.tintColor = .gray
        promptLabel.font = .systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            promptLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: promptLabel.bottomAnchor, multiplier: 4)
        ])
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: [])
        loginButton.titleLabel?.font = .systemFont(ofSize: 14)
        loginButton.tintColor = .blue
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: promptLabel.trailingAnchor, multiplier: 1)
        ])
    }
}
