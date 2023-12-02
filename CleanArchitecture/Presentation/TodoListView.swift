import SwiftUI

struct TodoListView: View {

    @StateObject
    private var vm = TodoListViewModel(
        getTodosUseCase: GetTodosUseCase(     todoRepository: TodoRepositoryImpl(
                datasource: TodoAPIDataSourceImpl()
            )
        )
    )
    
    
    fileprivate func listRow(_ todo: Todo) -> some View {
        HStack{
            Image(systemName: todo.isCompleted ? "checkmark.circle": "circle")
                .foregroundColor(todo.isCompleted ? .green : .red)
            Text("\(todo.title)")
        }
    }
    
    fileprivate func TodoList() -> some View {
        List {
            ForEach(vm.todos){ item in
                listRow(item)
            }
        }
        .navigationTitle("Todo List")
        .task {
           await vm.getTodos()
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
    
    var body: some View {
       TodoList()
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        TodoListView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
