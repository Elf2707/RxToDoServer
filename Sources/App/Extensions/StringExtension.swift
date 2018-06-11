//
//  StringExtension.swift
//  App
//
//  Created by Elf on 11.06.2018.
//

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true

        case "False", "false", "no", "0":
            return false

        default:
            return nil
        }
    }
}
