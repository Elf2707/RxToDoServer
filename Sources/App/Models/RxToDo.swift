//
//  RxToDo.swift
//  App
//
//  Created by Elf on 11.06.2018.
//

import Vapor
import FluentSQLite

final class RxToDo: SQLiteModel {
    var id: Int?
    var name: String
    var description: String
    var notes: String
    var completed: Bool
    var synced: Bool

    init(id: Int, name: String, description: String, notes: String,
         completed: Bool, synced: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.notes = notes
        self.completed = completed
        self.synced = synced
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension RxToDo: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension RxToDo: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension RxToDo: Parameter { }
