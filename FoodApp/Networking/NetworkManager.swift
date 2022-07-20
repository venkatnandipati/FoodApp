//
//  NetworkManager.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 11/07/22.
//

import Foundation
import UIKit
struct NetworkManager {
    /// This function is responsible to initialize network call with URLSession and returns a tuple of  optional Items Model and optional error.
    /// ```
    /// initiateServiceRequest
    /// ```
    /// - Warning: The function returns  an optional value also can throw an exception
    /// - Parameter resultType:  - Generic data model to capture decoded response
    /// - Parameter apiRequest:  - an instance of SetUpApiRequestProtocol protocol
    /// - Returns: result  success and failure response
    static func initiateServiceRequest<T: Decodable>(resultType: T.Type,
                                                     apiRequest: SetUpApiRequestProtocol
    ) async throws -> Result<T, CustomError> {
        if !Reachability.isConnectedToNetwork() {
            return .failure((.connectionFailed))
        }
        do {
            guard let _urlRequest = apiRequest.urlRequest else { return  .failure(.unexpected) }
            let (serverData, serverUrlResponse) = try await URLSession.shared.data(for: _urlRequest)
            guard let response = serverUrlResponse as? HTTPURLResponse else {
                return .failure(.dataError)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(resultType, from: serverData) else {
                    return .failure(.dataError)
                }
                return .success(decodedResponse)
            default:
                return .failure(.unexpected)
            }
        } catch {
            return .failure(.unexpected)
        }
    }
}
