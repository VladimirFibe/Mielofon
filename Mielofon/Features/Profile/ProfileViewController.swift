import UIKit

final class ProfileViewController: UIViewController {
    private let profileTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
// MARK: - Setup View
extension ProfileViewController {
    private func setupViews() {
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        setupProfileTableView()
    }
    
    private func setupProfileTableView() {
        view.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0,
                                                     width: profileTableView.frame.width,
                                                     height: 480))
        profileTableView.tableHeaderView = headerView
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
