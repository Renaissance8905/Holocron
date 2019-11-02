//
//  SWAPIDispatchGroup.swift
//  Holocron
//
//  Created by Chris Spradling on 8/18/19.
//

import Foundation

extension DispatchGroup {
    
    func handle<T: SWData>(_ queue: DispatchQueue, result: SWCollectionResult<T>, _ resultSet: inout [SWData], errors: inout [SWError]) {
       queue.sync {
           switch result {
           case .success(let data):
               resultSet.append(contentsOf: data)
           case .failure(let error):
               errors.append(error)
           }
           leave()
       }
    }
    
//    func notify<T>(_ queue: DispatchQueue, _ resultSet: [T], _ errors: [SWError], _ completion: ((Result<[T], SWError>) -> Void)?) {
//        
//        notify(queue: queue) {
//            if let error = errors.first {
//                completion?(.failure(error))
//                return
//
//            }
//
//            completion?(.success(resultSet))
//            return
//            
//        }
//        
//    }
    
}
