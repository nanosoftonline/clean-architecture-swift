import Foundation

protocol TodoDataSource{
    func getTodos() async throws -> [Todo]
}
