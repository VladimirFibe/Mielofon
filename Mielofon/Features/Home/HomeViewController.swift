import UIKit
import FirebaseAuth

final class HomeViewController: UIViewController {

    private let timelineTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        if Auth.auth().currentUser == nil {
            let controller = UINavigationController(rootViewController: OnboardingViewController())
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: false)
        }
    }
}
// MARK: - Actions
extension HomeViewController {
    @objc private func didTapProfile() {
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func didTapLogout() {
        do {
            try Auth.auth().signOut()
        } catch {}
    }
}

// MARK: - Setup Views
extension HomeViewController {
    private func setupViews() {
        setupTimelineTableView()
        configureNavigationBar()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapLogout))
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
