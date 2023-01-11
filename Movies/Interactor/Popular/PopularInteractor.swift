//
//  PopularPopularInteractor.swift
//  movies
//
//  Created by Vladimir Vassilyev on 29/12/2022.
//  Copyright © 2022 Vladimir. All rights reserved.
//

import Foundation

typealias PopularResult = Result<PopularResponseModel, NetworkResponse>

class PopularInteractor: BaseInteractor {
    func request(completion: @escaping (PopularResult) -> ()) {
        
        let completed = {
            (result: PopularResult) in
            
            if case let .success(message) = result {
                print("handle")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let parsed = networkManager.parse(completed)
//        networkManager.authProvider.request(
//            .signin(
//                nickname: nickname,
//                    password: password),
//            completion: parsed)
    }
}
