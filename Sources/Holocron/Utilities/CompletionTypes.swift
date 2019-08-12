//
//  CompletionTypes.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

public typealias SWResult<T: SWData> = Result<T, SWError>
public typealias SWCompletion<T: SWData> = (SWResult<T>) -> Void

public typealias SWCollectionResult<T: SWData> = Result<[T], SWError>
public typealias SWCollectionCompletion<T: SWData> = (SWCollectionResult<T>) -> Void
