//
//  PetFinderAPIClient.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import Foundation
import Combine

public enum PetFinderError: Error {
    case decoding(message: String)
    case apiError(message: String)
}

public enum PetNetworkError: Error {
    case noAccess
    case exceedAvailableRequests
    case apiError(message: String)
}

struct Token: Codable {
    var token: String
    var type: String
    var expiresIn: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expiresIn = "expires_in"
    }
}

extension PetNetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAccess:
            return NSLocalizedString("Developer has no access to a specified endpoint. It might happen if access token has been expired", comment: "401 Network Error")
        case .exceedAvailableRequests:
            return NSLocalizedString("Developer has exceeded available requests from plan", comment: "429 Network Error")
        case .apiError(message: let message):
            return NSLocalizedString(message, comment: "Network Error")
        }
    }
}

enum PetFinderStatus: String {
    case ok = "ok"
    case error = "error"
}

struct PetFinderApiErrorModel: Codable {
    var status: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case status, message
    }
}

struct PetFinderMessageErrorModel: Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

public protocol PetFinderApiClientProtocol {
    func getAnimals(forLocation location: String) -> AnyPublisher<Animal, PetNetworkError>

    func checkTokenExpiration()
}


class PetFinderApiClient: PetFinderApiClientProtocol {
    
    //
    // MARK: - Constants
    //

    private let session: URLSession
    private let scheme = "https"
    private let host = "api.petfinder.com"
    private let path = "/v2"
    private let hostPath = "https://api.petfinder.com"
    private let authorizationPath = "/v2/oauth2/token"
    // private let apiEndpoint = "https://api.petfinder.com/v1/keywords"
    
    private let clientID = "hnPhcHMRg8KhJEcqgSObWnqHfb2fmqsdcne4kGphAfBggx6LSG"
    private let clientSecret = "UWmU34VM2t1CDHzVbUTIiPl5Vm3k5r3x9ISUT9ym"
    private var token: String?
    private var tokenSaved: Bool?
    private var lastDateTokenSaved: Date?
    private let keychainService = KeychainService()
    
    // MARK: - Type Alias
    //

    // public typealias TagsResult = (Result<[TagModel], PetNetworkError>) -> Void
    private typealias Parameters = [String: String]
    
    //
    // MARK: - Init
    //

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func checkTokenExpiration() {
        if hasTokenExpired() {
            refreshToken()
        }
    }
    
    //
    // MARK: - Public Methods
    //

        public func getAnimals(forLocation location: String) -> AnyPublisher<Animal, PetNetworkError> {
            var components = URLComponents()
            components.scheme = self.scheme
            components.host = self.host
            components.path = self.path + "/animals"
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "location", value: location))
            queryItems.append(URLQueryItem(name: "distance", value: "1000"))
            components.queryItems = queryItems
            return searchPets(withComponents: components)
        }

        private func searchPets<T>(
            withComponents components: URLComponents
        ) -> AnyPublisher<T, PetNetworkError> where T: Decodable {
            guard let url = components.url else {
                let error = PetNetworkError.apiError(message: "Couldn't create URL")
                return Fail(error: error).eraseToAnyPublisher()
            }

            var request = URLRequest(url: url)
            guard let accessToken = keychainService.readToken() else {
                let error = PetNetworkError.apiError(message: "Invalid access token")
                return Fail(error: error).eraseToAnyPublisher()
            }
            request.httpMethod = "GET"
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            return session.dataTaskPublisher(for: request)
                .mapError { error in
                    PetNetworkError.apiError(message: error.localizedDescription)
            }.flatMap(maxPublishers: .max(1)) { pair in // Get first value result
                decode(pair.data)
            }
            .eraseToAnyPublisher() // Remove the AnyPublisher type
        }


    //
    // MARK: - Private Methods
    //
    
    private func signInRequest(completion: @escaping (String?) -> Void) {
        guard let request = signInUrlRequest() else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let response = response as? HTTPURLResponse,
               response.statusCode != 200 {
                completion(nil)
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                guard let token = self.parseToken(from: data)?.token else { return }
                completion(token)
            }
            
        }
        
        task.resume()
    }
    
    private func signInUrlRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: "\(clientID)"),
                                    URLQueryItem(name: "client_secret", value: "\(clientSecret)")]
        
        guard let url = URL(string: "https://api.petfinder.com/v2/oauth2/token") else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postData = "client_id=4W6PvhrpejcQ2uV8aPNtnLOD&client_secret=mSVrJKYPtTa1oHlqw7D1cUg54AGqux5E4y5WLCryGbCAg67t&grant_type=client_credentials".data(using: .utf8)
        request.httpBody = postData
        return request
    }
    
    private func parseToken(from data: Data) -> Token? {
        return parseData(data, as: Token.self)
    }
    
    private func parseMessageError(from data: Data) -> String? {
        return parseData(data, as: String.self)
    }
    
    private func parseData<T: Decodable>(_ data: Data, as type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(T.self, from: data)
            return parsedData
        } catch {
            return nil
        }
    }
    
    private func generateBoundary() -> String {
        return UUID().uuidString
    }
    
    private func hasTokenExpired() -> Bool {
        guard let lastDateTokenSaved = self.lastDateTokenSaved else { return true }
        let oneHourAgo = Date().addingTimeInterval(-3600)
        return lastDateTokenSaved < oneHourAgo
    }
    
    private func refreshToken() {
        signInRequest { [weak self] token in
            if let token = token {
                self?.tokenSaved = (self?.keychainService.saveToken(token: token)) != nil
                self?.lastDateTokenSaved = Date()
            }
        }
    }

    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, PetFinderError> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970
      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            PetFinderError.decoding(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}


extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        append(data)
    }
}
