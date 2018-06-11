import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class RxToDoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[RxToDo]> {
        return try JSON(node: RxToDoStore.sharedInstance.listItems())
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<RxToDo> {
        guard let id = req.headers["id"]?.int,
            let name = req.headers["name"],
            let description = req.headers["description"],
            let notes = req.headers["notes"],
            let completed = req.headers["completed"],
            let synced = req.headers["synced"]
       else {
            return try JSON(node: ["message": "Please include mandatory parameters"])
       }

       let todoItem = RxToDo(
            todoId: id,
            name: name,
            description: description,
            notes: notes,
            completed: completed.toBool()!,
            synced: synced.toBool()!
        )

        let todos = RxTodoStore.sharedInstance
            todos.addOrUpdateItem(item: todoItem)
        let json = todos.listItems()

        return try JSON(node: json)
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}
