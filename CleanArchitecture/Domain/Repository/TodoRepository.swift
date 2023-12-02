import Foundation

protocol TodoRepository{
    func getTodos() async throws -> [Todo]
}
