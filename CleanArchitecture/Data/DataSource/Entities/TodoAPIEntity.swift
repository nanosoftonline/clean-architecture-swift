//This is the shape of the Todo from the API
import Foundation

//Codable, when used with well-formatted JSON, eliminates almost all of the checks that parsing code requires for returning a data object
struct TodoAPIEntity: Codable {
    let id: Int
    let title: String
    let completed: Bool
}
