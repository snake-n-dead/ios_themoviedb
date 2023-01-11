//
//  NetworkManager.swift
//

import Foundation

enum NetworkResponse: Error, Equatable {    
    case success
    case error(message: String)
    case authenticationError
    case sessionExpired
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    
    var message: String {
        switch self {
        case .success:
            return "Success"
        case .error(let message):
            return message
        case .authenticationError:
            return "You need to be authenticated first."
        case .sessionExpired:
            return "Your session is expired."
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.message == rhs.message
    }
}

protocol NetworkManagerProtocol {
    var privateProvider: Provider<PrivateApi> { get }

    func parse<T: Codable>(
        _ completion: @escaping (Result<T, NetworkResponse>) -> ()) -> NetworkRouterCompletion
}

class NetworkManager: NetworkManagerProtocol {
    
    var privateProvider = Provider<PrivateApi>()

    func parse<T: Codable>(
        _ completion: @escaping (Result<T, NetworkResponse>) -> ()) -> NetworkRouterCompletion {
            return { [weak self]
            data, response, error in
            
            if error != nil {
                completion(.failure(.error(message: "Please check your network connection.")))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self?.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        print(error)
                        completion(.failure(NetworkResponse.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    var failureError = networkFailureError
                    if let data = data {
                        let apiResponse = try? JSONDecoder().decode(Message<String>.self, from: data)
                        
                        var error = ""
                        if let apiResponse = apiResponse {
                            error = apiResponse.results
                        }
                        else if let string = String(data: data, encoding: .utf8) {
                            error = string
                        }
                        
                        failureError = .error(message: error)
                    }

                    completion(.failure(failureError))
                    
                case .none:
                    break
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Void, NetworkResponse> {
        switch response.statusCode {
            case 200...299: return .success(())
            case 419: return .failure(NetworkResponse.sessionExpired)
            case 401...500: return .failure(NetworkResponse.authenticationError)
            case 501...599: return .failure(NetworkResponse.badRequest)
            case 600: return .failure(NetworkResponse.outdated)
            default: return .failure(NetworkResponse.failed)
        }
    }
}
