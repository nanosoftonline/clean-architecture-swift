import Foundation

@MainActor
class TodoListViewModel: ObservableObject {
    
    private var getTodosUseCase : GetTodos
    
    init(getTodosUseCase: GetTodos){
        self.getTodosUseCase = getTodosUseCase
    }
    
    @Published
    var todos: [Todo] = []
    
    @Published
    var errorMessage = ""
    
    @Published
    var hasError = false
    
    func getTodos() async {
        errorMessage = ""
        let result = await self.getTodosUseCase.execute()
        switch result{
        case .success(let todos):
            self.todos = todos
        case .failure(let error):
            self.todos = []
            
            if(error == UseCaseError.dataSourceError){
                errorMessage = "Data Source Error"
            }
            
            if(error == UseCaseError.decodingError){
                errorMessage = "Data Decoding Error"
            }
            hasError = true
        }
    }
}
