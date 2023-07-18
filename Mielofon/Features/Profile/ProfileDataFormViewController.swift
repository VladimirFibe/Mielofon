import UIKit
import Combine
import PhotosUI

final class ProfileDataFormViewController: UIViewController {
    
    private let viewModel = ProfileDataFormViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let scrollView = UIScrollView()
    private let hintLabel = UILabel()
    private let avatarPlaceholderImageView = UIImageView()
    private let displayNameTextField = UITextField()
    private let usernameTextField = UITextField()
    private let bioTextView = UITextView()
    private let submitButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
// MARK: - Actions
extension ProfileDataFormViewController {
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}
// MARK: - Setup Views
extension ProfileDataFormViewController {
    private func setupViews() {
        setupView()
        setupScrollView()
        setupHintLabel()
        setupAvatarPlaceholderImageView()
        setupDisplayNameTextField()
        setupUsernameTextField()
        setupBioTextView()
        setupSubmitButton()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        isModalInPresentation = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupHintLabel() {
        scrollView.addSubview(hintLabel)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = "Fill in your data"
        hintLabel.font = .systemFont(ofSize: 32, weight: .bold)
        hintLabel.textColor = .label
        hintLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.topAnchor, multiplier: 1),
            hintLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            scrollView.trailingAnchor.constraint(equalToSystemSpacingAfter: hintLabel.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupAvatarPlaceholderImageView() {
        scrollView.addSubview(avatarPlaceholderImageView)
        avatarPlaceholderImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarPlaceholderImageView.clipsToBounds = true
        avatarPlaceholderImageView.layer.masksToBounds = true
        avatarPlaceholderImageView.layer.cornerRadius = 60
        avatarPlaceholderImageView.backgroundColor = .lightGray
        avatarPlaceholderImageView.image = UIImage(systemName: "camera.fill")
        avatarPlaceholderImageView.tintColor = .gray
        avatarPlaceholderImageView.isUserInteractionEnabled = true
        avatarPlaceholderImageView.contentMode = .scaleAspectFill
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
        NSLayoutConstraint.activate([
            avatarPlaceholderImageView.topAnchor.constraint(equalToSystemSpacingBelow: hintLabel.bottomAnchor, multiplier: 2),
            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupDisplayNameTextField() {
        scrollView.addSubview(displayNameTextField)
        displayNameTextField.translatesAutoresizingMaskIntoConstraints = false
        displayNameTextField.backgroundColor = .secondarySystemFill
        displayNameTextField.leftViewMode = .always
        displayNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        displayNameTextField.layer.masksToBounds = true
        displayNameTextField.layer.cornerRadius = 8
        displayNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Display Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        displayNameTextField.delegate = self
        NSLayoutConstraint.activate([
            displayNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: avatarPlaceholderImageView.bottomAnchor, multiplier: 2),
            displayNameTextField.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
            displayNameTextField.trailingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            displayNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupUsernameTextField() {
        scrollView.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.backgroundColor = .secondarySystemFill
        usernameTextField.leftViewMode = .always
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.cornerRadius = 8
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "User Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: displayNameTextField.bottomAnchor, multiplier: 1),
            usernameTextField.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBioTextView() {
        scrollView.addSubview(bioTextView)
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.backgroundColor = .secondarySystemFill
        bioTextView.layer.masksToBounds = true
        bioTextView.layer.cornerRadius = 8
        bioTextView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        bioTextView.text = "Tell the world about yourself"
        bioTextView.textColor = .gray
        bioTextView.font = .systemFont(ofSize: 16)
        bioTextView.delegate = self
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalToSystemSpacingBelow: usernameTextField.bottomAnchor, multiplier: 1),
            bioTextView.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            bioTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupSubmitButton() {
        scrollView.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.backgroundColor = .blue
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 8
        submitButton.tintColor = .white
        submitButton.setTitle("Submit", for: [])
        submitButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold )
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            view.keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: submitButton.bottomAnchor, multiplier: 1)
        ])
    }
}

extension ProfileDataFormViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(.zero, animated: true)
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "Tell the world about yourself"
        }
    }
}

extension ProfileDataFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(.zero, animated: true)
    }
}

extension ProfileDataFormViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                    }
                }
            }
        }
    }
    
    
}
