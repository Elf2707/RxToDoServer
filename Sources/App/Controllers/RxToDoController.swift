import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class RxToDoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> [RxToDo] {
        return RxToDoStore.sharedInstance.listItems()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> [RxToDo] {
        let newToDo =  try JSONDecoder().decode(RxToDo.self, from: req.http.body.data!)
        newToDo.id = Int(arc4random())
        RxToDoStore.sharedInstance.addOrUpdateItem(item: newToDo)

        return RxToDoStore.sharedInstance.listItems()
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> HTTPStatus {
        if let id = try? req.parameters.next(Int.self) {
            let _ = RxToDoStore.sharedInstance.delete(id: id)
            return .ok
        }

        return .badRequest
    }
}
