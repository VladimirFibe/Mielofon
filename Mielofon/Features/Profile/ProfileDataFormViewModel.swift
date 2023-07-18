import UIKit
import Combine
import FirebaseStorage

final class ProfileDataFormViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var displayName = ""
    @Published var username = ""
    @Published var bio = ""
    @Published var avatarPath = ""
    @Published var image: UIImage? = nil
    @Published var isFormValid = false
    @Published var error: String? = nil
    @Published var url: URL? = nil
    func validateUserProfileForm() {
        isFormValid = displayName.count > 2 && username.count > 2 && bio.count > 2 && image != nil
    }
    
    func uploadAvatar() {
        let randomID = UUID().uuidString
        guard let image = image?.jpegData(compressionQuality: 0.6) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        StorageManager.shared.uploadProfilePhoto(with: randomID,
                                                 image: image,
                                                 metaData: metaData)
        .flatMap({ metaData in
            StorageManager.shared.getDownloadURL(for: metaData.path)
        })
        .sink(receiveCompletion: { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        }, receiveValue: { [weak self] url in
            self?.url = url
        })
        .store(in: &subscriptions)
        
    }
}
