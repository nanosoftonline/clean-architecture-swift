import Foundation

enum UseCaseError: Error{
    case dataSourceError, decodingError
}

protocol GetTodos {
    func execute() async -> Result<[Todo], UseCaseError>
}

struct GetTodosUseCase: GetTodos{
    private var todoRepository :TodoRepository
    
    init(todoRepository: TodoRepository){
        self.todoRepository = todoRepository
    }
    
    func execute() async -> Result<[Todo], UseCaseError>{
        do{
            let todos = try await todoRepository.getTodos()
            return .success(todos)
        }catch(let error){
            switch(error){
            case APIServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.dataSourceError)
            }
        }
    }
}
