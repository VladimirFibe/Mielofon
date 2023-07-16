import UIKit

class OnboardingViewController: UIViewController {

    private let welcomeLabel = UILabel()
    private let createAccountButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup Views
extension OnboardingViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Onboarding"
        setupWelcomeLabel()
        setupCreateAccountButton()
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
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalToSystemSpacingBelow: welcomeLabel.bottomAnchor, multiplier: 2),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
