//
//  Session.swift
//  Sales
//
//  Created by Vladimir Vasilyev on 28.12.2022.
//

import Foundation

typealias Credentials = (username: String, password: String)

struct Session {
    static var isAuthorized: Bool {
        return access != nil
    }
    
    static var access: String? { "" }
    static var refresh: String? { "" }
}
