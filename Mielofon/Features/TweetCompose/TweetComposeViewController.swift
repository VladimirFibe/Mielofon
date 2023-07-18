import UIKit
import Combine
final class TweetComposeViewController: UIViewController {
    private let viewModel = TweetComposeViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let tweetButton = UIButton(type: .system)
    private let tweetTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
// MARK: - Action
extension TweetComposeViewController {
    @objc private func didTapToCancell() {
        dismiss(animated: true)
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapToTweet() {
        viewModel.dispatchTweet()
    }
    
    private func bindViews() {
        viewModel.$isValidToTweet
            .sink { [weak self] state in
                self?.tweetButton.isEnabled = state
            }
            .store(in: &subscriptions)
        
        viewModel.$shouldDismissCompose
            .sink { [weak self] success in
                if success {
                    self?.dismiss(animated: true)
                }
            }
            .store(in: &subscriptions)
    }
}
// MARK: - Setup Views
extension TweetComposeViewController {
    private func setupViews() {
        setupView()
        setupTweetButton()
        setupTweetTextView()
        viewModel.getPerson()
        bindViews()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapToCancell))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
    }
    private func setupTweetButton() {
        view.addSubview(tweetButton)
        tweetButton.translatesAutoresizingMaskIntoConstraints = false
        tweetButton.backgroundColor = .twitterBlueColor
        tweetButton.setTitle("Tweet", for: [])
        tweetButton.setTitleColor(.white, for: .normal)
        tweetButton.setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
        tweetButton.layer.cornerRadius = 15
        tweetButton.layer.masksToBounds = true
        tweetButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        tweetButton.isEnabled = false
        tweetButton.addTarget(self, action: #selector(didTapToTweet), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: tweetButton.bottomAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tweetButton.trailingAnchor, multiplier: 2),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTweetTextView() {
        view.addSubview(tweetTextView)
        tweetTextView.translatesAutoresizingMaskIntoConstraints = false
        tweetTextView.layer.masksToBounds = true
        tweetTextView.layer.cornerRadius = 8
        tweetTextView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = .gray
        tweetTextView.font = .systemFont(ofSize: 16)
        tweetTextView.delegate = self
        NSLayoutConstraint.activate([
            tweetTextView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            tweetTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tweetTextView.trailingAnchor, multiplier: 2),
            tweetButton.topAnchor.constraint(equalToSystemSpacingBelow: tweetTextView.bottomAnchor, multiplier: 2)
        ])
    }
}

extension TweetComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "What's happening?"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        viewModel.tweetContent = text
        viewModel.validateToTweet()
    }
}
