//
//  Extensions.swift
//  ToDoList
//
//  Created by Mehdi on 2024-02-09.
//

import Foundation

extension Encodable {
    // Function to convert an encodable object to a dictionary
    func asDictionary() -> [String: Any] {
        // Attempt to encode the object to JSON data
        guard let data = try? JSONEncoder().encode(self) else {
            // If encoding fails, return an empty dictionary
            return [:]
        }
        
        // Try to deserialize the JSON data into a dictionary
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            // If deserialization fails, return an empty dictionary
            return [:]
        }
    }
}
