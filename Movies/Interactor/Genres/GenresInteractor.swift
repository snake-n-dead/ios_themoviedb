//
//  GenresGenresInteractor.swift
//

import Foundation

typealias GenresResult = Result<GenresResponseModel, NetworkResponse>

final class GenresInteractor: BaseInteractor {
    func request(completion: @escaping (GenresResult) -> ()) {
        
        let completed = {
            (result: GenresResult) in

            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let parsed = networkManager.parse(completed)
    }
}
