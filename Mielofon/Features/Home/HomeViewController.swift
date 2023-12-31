import UIKit
import FirebaseAuth
import Combine
final class HomeViewController: UIViewController {

    private var viewModel = HomeViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    private let timelineTableView = UITableView()
    private let composeTweetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retrivePerson()
    }
}
// MARK: - Actions
extension HomeViewController {
    @objc private func didTapProfile() {
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func didTapLogout() {
        AuthManager.shared.signOut()
        handleAuthentication()
    }
    
    @objc private func didTapCompose() {
        let controller = UINavigationController(rootViewController: TweetComposeViewController())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let controller = UINavigationController(rootViewController: OnboardingViewController())
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: false)
        }
    }
    
    private func bindViews() {
        viewModel.$person
            .sink { [weak self] person in
                guard let person else { return }
                if !person.isUserOnboarded {
                    self?.comletePersonOnboarding()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func comletePersonOnboarding() {
        let controller = ProfileDataFormViewController()
        present(controller, animated: true)
    }
}

// MARK: - Setup Views
extension HomeViewController {
    private func setupViews() {
        setupTimelineTableView()
        configureNavigationBar()
        setupComposeTweetButton()
        bindViews()
    }
    
    private func setupTimelineTableView() {
        view.addSubview(timelineTableView)
        timelineTableView.translatesAutoresizingMaskIntoConstraints = false
        timelineTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        NSLayoutConstraint.activate([
            timelineTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timelineTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timelineTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleToFill
        logoImageView.image = UIImage(named: "twitterLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapProfile))
        
        let logoutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logoutImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapLogout))
    }
    
    private func setupComposeTweetButton() {
        view.addSubview(composeTweetButton)
        composeTweetButton.translatesAutoresizingMaskIntoConstraints = false
        composeTweetButton.addTarget(self, action: #selector(didTapCompose), for: .primaryActionTriggered)
        composeTweetButton.backgroundColor = .twitterBlueColor
        composeTweetButton.tintColor = .white
        let plusSign = UIImage(systemName: "plus",
                               withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))
        composeTweetButton.setImage(plusSign, for: [])
        composeTweetButton.layer.cornerRadius = 28
        composeTweetButton.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            composeTweetButton.widthAnchor.constraint(equalToConstant: 56),
            composeTweetButton.heightAnchor.constraint(equalToConstant: 56),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: composeTweetButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: composeTweetButton.bottomAnchor, multiplier: 2)
        ])
    }
}
// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: TweetTableViewCellDelegate {
    func tweetDidTapReplay() {
        print(#function)
    }
    
    func tweetDidTapRetweet() {
        print(#function)
    }
    
    func tweetDidTapLike() {
        print(#function)
    }
    
    func tweetDidTapShare() {
        print(#function)
    }
}
