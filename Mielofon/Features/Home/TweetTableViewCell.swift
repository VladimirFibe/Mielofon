import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func tweetDidTapReplay()
    func tweetDidTapRetweet()
    func tweetDidTapLike()
    func tweetDidTapShare()
}
final class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"
    private let avatarImageView = UIImageView()
    private let displayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let tweetTextContentLabel = UILabel()
    private let replyButton = UIButton(type: .system)
    private let retweetButton = UIButton(type: .system)
    private let likeButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    
    weak var delegate: TweetTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension TweetTableViewCell {
    @objc private func didTapReply() {
        delegate?.tweetDidTapReplay()
    }
    
    @objc private func didTapRetweet() {
        delegate?.tweetDidTapRetweet()
    }
    
    @objc private func didTapLike() {
        delegate?.tweetDidTapLike()
    }
    
    @objc private func didTapShare() {
        delegate?.tweetDidTapShare()
    }
}
// MARK: - Setup Views
extension TweetTableViewCell {
    private func setupViews() {
        setupAvatarImageView()
        setupDisplayNameLabel()
        setupUsernameLabel()
        setupTweetTextContentLabel()
        setupReplyButton()
        setupRetweetButton()
        setupLikeButton()
        setupShareButton()
    }
    
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(systemName: "person")
        avatarImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            avatarImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupDisplayNameLabel() {
        contentView.addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        displayNameLabel.text = "Vladimir Fibe"
        displayNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        NSLayoutConstraint.activate([
            displayNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            displayNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "@macuser"
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.font = .systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: displayNameLabel.trailingAnchor, multiplier: 1),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor)
        ])
    }
    
    private func setupTweetTextContentLabel() {
        contentView.addSubview(tweetTextContentLabel)
        tweetTextContentLabel.translatesAutoresizingMaskIntoConstraints = false
        tweetTextContentLabel.text = "Супербыстрые чипы M1 Pro и M1 Max дают феноменальную производительность и обеспечивают удивительно долгое время работы без подзарядки. Прибавьте к этому потрясающий дисплей Liquid Retina XDR и ещё больше портов для профессиональной работы. Это тот самый ноутбук, который вы так ждали."
        tweetTextContentLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalToSystemSpacingBelow: displayNameLabel.bottomAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: tweetTextContentLabel.trailingAnchor, multiplier: 1),
        ])
    }
    
    private func setupReplyButton() {
        contentView.addSubview(replyButton)
        replyButton.translatesAutoresizingMaskIntoConstraints = false
        replyButton.setImage(UIImage(systemName: "bubble.left"), for: [])
        replyButton.tintColor = .systemGray2
        replyButton.addTarget(self, action: #selector(didTapReply), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            replyButton.topAnchor.constraint(equalToSystemSpacingBelow: tweetTextContentLabel.bottomAnchor, multiplier: 2),
            replyButton.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: replyButton.bottomAnchor, multiplier: 1)

        ])
    }
    
    private func setupRetweetButton() {
        contentView.addSubview(retweetButton)
        retweetButton.translatesAutoresizingMaskIntoConstraints = false
        retweetButton.setImage(UIImage(systemName: "arrow.2.squarepath"), for: [])
        retweetButton.tintColor = .systemGray2
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            retweetButton.topAnchor.constraint(equalTo: replyButton.topAnchor),
            retweetButton.leadingAnchor.constraint(equalToSystemSpacingAfter: replyButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupLikeButton() {
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(systemName: "heart"), for: [])
        likeButton.tintColor = .systemGray2
        likeButton.addTarget(self, action: #selector(didTapLike), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: replyButton.topAnchor),
            likeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: retweetButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupShareButton() {
        contentView.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: [])
        shareButton.tintColor = .systemGray2
        shareButton.addTarget(self, action: #selector(didTapShare), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: replyButton.topAnchor),
            shareButton.leadingAnchor.constraint(equalToSystemSpacingAfter: likeButton.trailingAnchor, multiplier: 2)
        ])
    }
}
