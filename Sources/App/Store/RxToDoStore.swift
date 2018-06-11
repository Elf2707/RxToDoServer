//
//  RxToDoStore.swift
//  App
//
//  Created by Elf on 11.06.2018.
//

import Vapor

final class RxToDoStore {
    static let sharedInstance = RxToDoStore()
    fileprivate var list = Array<RxToDo>()

    private init() {
    }

    func addOrUpdateItem(item: RxToDo) {
        if self.find(id: item.todoId) != nil {
            _ = update(item: item)
        } else {
            self.list.append(item)
        }
    }

    func listItems() -> [RxToDo] {
        return self.list
    }

    func find(id: Int) -> RxToDo? {
        return self.list.index { $0.todoId == id }.map { self.list[$0] }
    }

    func delete(id: Int) -> String {
        if self.find(id: id) != nil {
            self.list = self.list.filter { $0.todoId != id }
            return "Item is deleted"
        }

        return "Item not found"
    }

    func deleteAll() -> String {
        if self.list.count > 0 {
            self.list.removeAll()
            return "All items were deleted"
        }

        return "List was empty"
    }

    func update(item: RxToDo) -> String {
        if let index = (self.list.index { $0.todoId == item.todoId }) {
            self.list[index] = item
            return "item is up to date"
        }

        return "item not found"
    }
}
