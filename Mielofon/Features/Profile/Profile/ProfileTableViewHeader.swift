import UIKit
import Kingfisher
final class ProfileTableViewHeader: UIView {

    private var selectedTab = 0 { didSet {
        for i in sectionStack.arrangedSubviews.indices {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.sectionStack.arrangedSubviews[i].tintColor = self?.selectedTab == i ? .label : .secondaryLabel
                self?.leadingAnchors[i].isActive = i == self?.selectedTab
                self?.trailingAnchors[i].isActive = i == self?.selectedTab
                self?.layoutIfNeeded()
            }
        }
    }}
    private let profileHeaderImageView = UIImageView()
    private let profileAvatarImageView = UIImageView()
    private let displayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let userBioLabel = UILabel()
    private let joinDateImageView = UIImageView()
    private let joinDateLabel = UILabel()
    private let followingCountLabel = UILabel()
    private let followingTextLabel = UILabel()
    private let followersCountLabel = UILabel()
    private let followersTextLabel = UILabel()
    private let sectionStack = UIStackView()
    private let indicator = UIView()
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: Person) {
        let url = URL(string: person.avatar)
        profileAvatarImageView.kf.setImage(with: url)
        displayNameLabel.text = person.displayName
        usernameLabel.text = "@\(person.username)"
        userBioLabel.text = person.bio
        followersCountLabel.text = "\(person.followersCount)"
        followingCountLabel.text = "\(person.followingCount)"
    }
}
// MARK: - Actions
extension ProfileTableViewHeader {
    @objc private func didTapTab(_ sender: UIButton) {
        selectedTab = sender.tag
    }
}
// MARK: - Setup Views
extension ProfileTableViewHeader {
    private func setupViews() {
        setupProfileHeaderImageView()
        setupProfileAvatarImageView()
        setupDisplayNameLabel()
        setupUsernameLabel()
        setupUserBioLabel()
        setupJoinDateImageView()
        setupJoinDateLabel()
        setupFollowingCountLabel()
        setupFollowingTextLabel()
        setupFollowersCountLabel()
        setupFollowersTextLabel()
        setupIndicator()
        setupSectionStack()
    }
    
    private func setupProfileHeaderImageView() {
        addSubview(profileHeaderImageView)
        profileHeaderImageView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderImageView.image = UIImage(named: "header")
        profileHeaderImageView.contentMode = .scaleAspectFill
        profileHeaderImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupProfileAvatarImageView() {
        addSubview(profileAvatarImageView)
        profileAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        profileAvatarImageView.image = UIImage(systemName: "person.circle.fill")
        profileAvatarImageView.backgroundColor = .systemBackground
        profileAvatarImageView.contentMode = .scaleAspectFill
        profileAvatarImageView.clipsToBounds = true
        profileAvatarImageView.layer.masksToBounds = true
        profileAvatarImageView.layer.cornerRadius = 40
        NSLayoutConstraint.activate([
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupDisplayNameLabel() {
        addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        displayNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        displayNameLabel.textColor = .label
        NSLayoutConstraint.activate([
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: profileAvatarImageView.bottomAnchor, multiplier: 2)
        ])
    }
    
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.font = .systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalToSystemSpacingBelow: displayNameLabel.bottomAnchor, multiplier: 1)
        ])
    }

    private func setupUserBioLabel() {
        addSubview(userBioLabel)
        userBioLabel.translatesAutoresizingMaskIntoConstraints = false
        userBioLabel.numberOfLines = 3
        userBioLabel.textColor = .label
        userBioLabel.font = .systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            userBioLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            userBioLabel.topAnchor.constraint(equalToSystemSpacingBelow: usernameLabel.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: userBioLabel.trailingAnchor, multiplier: 1),
        ])
    }
    
    private func setupJoinDateImageView() {
        addSubview(joinDateImageView)
        joinDateImageView.translatesAutoresizingMaskIntoConstraints = false
        joinDateImageView.image = UIImage(systemName: "calendar",
                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        joinDateImageView.tintColor = .secondaryLabel
        NSLayoutConstraint.activate([
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalToSystemSpacingBelow: userBioLabel.bottomAnchor, multiplier: 1)
        ])
    }
    
    private func setupJoinDateLabel() {
        addSubview(joinDateLabel)
        joinDateLabel.translatesAutoresizingMaskIntoConstraints = false
        joinDateLabel.textColor = .secondaryLabel
        joinDateLabel.text = "Joined May 2009"
        joinDateLabel.font = .systemFont(ofSize: 14)
        NSLayoutConstraint.activate([
            joinDateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: joinDateImageView.trailingAnchor, multiplier: 1),
            joinDateLabel.centerYAnchor.constraint(equalTo: joinDateImageView.centerYAnchor)
        ])
    }
    
    private func setupFollowingCountLabel() {
        addSubview(followingCountLabel)
        followingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        followingCountLabel.textColor = .label
        followingCountLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        NSLayoutConstraint.activate([
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalToSystemSpacingBelow: joinDateImageView.bottomAnchor, multiplier: 1)
        ])
    }
    
    private func setupFollowingTextLabel() {
        addSubview(followingTextLabel)
        followingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        followingTextLabel.text = "Following"
        followingTextLabel.textColor = .secondaryLabel
        followingTextLabel.font = .systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            followingTextLabel.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            followingTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: followingCountLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setupFollowersCountLabel() {
        addSubview(followersCountLabel)
        followersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        followersCountLabel.textColor = .label
        followersCountLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        NSLayoutConstraint.activate([
            followersCountLabel.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            followersCountLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: followingTextLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setupFollowersTextLabel() {
        addSubview(followersTextLabel)
        followersTextLabel.translatesAutoresizingMaskIntoConstraints = false
        followersTextLabel.text = "Followers"
        followersTextLabel.textColor = .secondaryLabel
        followersTextLabel.font = .systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            followersTextLabel.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            followersTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: followersCountLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setupIndicator() {
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .systemBlue
    }
    
    private func setupSectionStack() {
        addSubview(sectionStack)
        sectionStack.translatesAutoresizingMaskIntoConstraints = false
        sectionStack.axis = .horizontal
        sectionStack.distribution = .equalSpacing
        var tag = 0
        ["Tweets", "Tweets & Relies", "Media", "Likes"].forEach {
            let button = UIButton(type: .system)
            button.setTitle($0, for: [])
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = tag == 0 ? .label : .secondaryLabel
            button.tag = tag
            tag += 1
            button.addTarget(self, action: #selector(didTapTab), for: .primaryActionTriggered)
            sectionStack.addArrangedSubview(button)
            leadingAnchors.append(indicator.leadingAnchor.constraint(equalTo: button.leadingAnchor))
            trailingAnchors.append(indicator.trailingAnchor.constraint(equalTo: button.trailingAnchor))
        }
        
        NSLayoutConstraint.activate([
            sectionStack.topAnchor.constraint(equalToSystemSpacingBelow: followingCountLabel.bottomAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: sectionStack.trailingAnchor, multiplier: 2),
            sectionStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.bottomAnchor, constant: 1),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    

}
