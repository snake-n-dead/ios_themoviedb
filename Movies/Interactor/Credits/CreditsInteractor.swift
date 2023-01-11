//
//  CreditsCreditsInteractor.swift
//

import Foundation

typealias CreditsResult = Result<CreditsResponseModel, NetworkResponse>

final class CreditsInteractor: BaseInteractor {
    func request(movieId: String, completion: @escaping (CreditsResult) -> ()) {
        
        let completed = {
            (result: CreditsResult) in
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let parsed = networkManager.parse(completed)
        networkManager.privateProvider.request(
            .getCredits(movieId: movieId),
            completion: parsed)
    }
}
