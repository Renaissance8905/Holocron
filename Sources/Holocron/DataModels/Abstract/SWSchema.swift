//
//  SWSchema.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

// TODO: the complicated part of this is that the property list is a
//       dictionary, not an array. Will need custom decoding

public struct SWSchema: Codable {

    public struct Property: Codable {
        let type: String
        let format: String?
        let description: String
    }

    let description: String
    let required: [String]
    let type: String
    let title: String

    let properties: [Property] // [String: Property]

}
