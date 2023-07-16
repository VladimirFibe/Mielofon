import UIKit

final class ProfileTableViewHeader: UIView {

    private let profileHeaderImageView = UIImageView()
    private let profileAvatarImageView = UIImageView()
    private let displayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let userBioLabel = UILabel()
    private let joinDateImageView = UIImageView()
    private let joinDateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 180)
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
        displayNameLabel.text = "Vladimir Fibe"
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
        usernameLabel.text = "@macuser"
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
        userBioLabel.text = "iOS Developer"
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
}
