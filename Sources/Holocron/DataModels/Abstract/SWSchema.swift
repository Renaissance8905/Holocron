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
        var type: String
        var format: String?
        var description: String
    }

    var description: String
    var required: [String]
    var type: String
    var title: String

    var properties: [Property] // [String: Property]

}
