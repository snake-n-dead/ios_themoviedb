//
//  PopularPopularInteractor.swift
//

import Foundation

typealias PopularResult = Result<PopularResponseModel, NetworkResponse>

class PopularInteractor: BaseInteractor {
    func request(page: Int, completion: @escaping (PopularResult) -> ()) {
        
        let completed = {
            (result: PopularResult) in
                        
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let parsed = networkManager.parse(completed)
        networkManager
            .privateProvider
            .request(
                .getPopular(page: page),
                completion: parsed)
    }
}
