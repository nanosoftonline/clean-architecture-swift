import Foundation

struct TodoRepositoryImpl: TodoRepository{
    private var datasource : TodoDataSource

    init(datasource: TodoDataSource){
        self.datasource = datasource
    }
            
    func getTodos() async throws -> [Todo] {
        let _todos =  try await datasource.getTodos()
        return _todos
    }
}
