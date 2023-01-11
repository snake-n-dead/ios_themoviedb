//
//  BaseInteractor .swift
//

import Foundation

class BaseInteractor {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}
