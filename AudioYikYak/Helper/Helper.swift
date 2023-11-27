//
//  Helper.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/27/23.
//

import Foundation

func getFileDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
       let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
