//
//  Result.swift
//  UpMovie
//
//  Created by Lucas  Felipe on 28/02/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import Foundation

struct UpMovieError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
    
}

enum Result<T> {
    case success(T)
    case fail(Error)
    
    public func answered() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .fail(error):
            throw error
        }
    }
}
