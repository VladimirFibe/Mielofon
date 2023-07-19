import Foundation

struct Tweet: Codable {
    var id = UUID().uuidString
    let person: Person
    let uid: String
    let content: String
    var likes: Int
    var likers: [String]
    let isReply: Bool
    let parent: String?
}
