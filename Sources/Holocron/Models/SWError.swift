//
//  SWError.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

public enum SWError: Error {
    case invalidURL
    case noData
    case decodingError(DecodingError)
    case responseError(Error)
}
