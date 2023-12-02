import Foundation

enum APIServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}

struct TodoAPIDataSourceImpl: TodoDataSource{
    
       
    func getTodos() async throws -> [Todo] {
        
        guard let url = URL(string:  "\(Constants.BASE_URL)/todos") else{
            throw APIServiceError.badUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIServiceError.statusNotOK
        }
        
        guard let result = try? JSONDecoder().decode([TodoAPIEntity].self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return result.map({ todoEntity in
            Todo(
                id: todoEntity.id,
                title: todoEntity.title,
                isCompleted: todoEntity.completed
            )
        })
    }
}
