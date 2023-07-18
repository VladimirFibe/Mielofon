import Foundation

struct Tweet: Codable {
    var id = UUID().uuidString
    let author: Person
    let content: String
    var likes: Int
    var likers: [String]
    let isReply: Bool
    let parent: String?
}
