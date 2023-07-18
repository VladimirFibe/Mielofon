import UIKit
import Combine

final class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    private var isStatusBarHidden = true
    private var statusBarHeight: CGFloat { view.bounds.height > 800 ? 40 : 20 }
    private let statusBar = UIView()
    private let profileTableView = UITableView()
    private lazy var headerView = ProfileTableViewHeader(
        frame: CGRect(x: 0, y: 0,
                      width: profileTableView.frame.width,
                      height: 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrivePerson()
    }
}
// MARK: - Action
extension ProfileViewController {
    private func bindViews() {
        viewModel.$person
            .sink {[weak self] person in
                if let person {
                    self?.headerView.configure(with: person)
                }
            }
            .store(in: &subscriptions)
    }
}
// MARK: - Setup View
extension ProfileViewController {
    private func setupViews() {
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupProfileTableView()
        setupStatusBar()
        bindViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupStatusBar() {
        view.addSubview(statusBar)
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.backgroundColor = .systemBackground
        statusBar.layer.opacity = 0
        NSLayoutConstraint.activate([
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: statusBarHeight)
        ])
    }
    
    private func setupProfileTableView() {
        view.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableHeaderView = headerView
        profileTableView.contentInsetAdjustmentBehavior = .never
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        if yPosition > (150 - statusBarHeight) && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            }
        } else if yPosition < (150 - statusBarHeight) && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
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

extension ProfileViewController: TweetTableViewCellDelegate {
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
