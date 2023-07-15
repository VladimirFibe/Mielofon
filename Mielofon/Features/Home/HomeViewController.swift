import UIKit

final class HomeViewController: UIViewController {

    private let timelineTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup Views
extension HomeViewController {
    private func setupViews() {
        setupTimelineTableView()
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
