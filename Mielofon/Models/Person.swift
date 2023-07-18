import Foundation
import Firebase

struct Person: Codable {
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount = 0
    var followingCount = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatar: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
}
