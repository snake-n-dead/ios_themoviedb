//
//  Cancellable.swift
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {

}
