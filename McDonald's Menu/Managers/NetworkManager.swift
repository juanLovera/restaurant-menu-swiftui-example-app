//
//  NetworkManager.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func request<B: Codable, R: Codable>(url: URL,
                             query: [String: String],
                             method: RequestMethod,
                             body: B,
                             headers: [String: String]) async -> RequestResult<R>
}

class NetworkManager: NetworkManagerProtocol {
    
    static let instance: NetworkManagerProtocol = NetworkManager()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    init() {
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func request<B: Codable, R: Codable>(url: URL,
                             query: [String: String] = [:],
                             method: RequestMethod = .get,
                             body: B,
                             headers: [String: String] = [:]) async -> RequestResult<R> {
        
        let queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for header in headers {
            request.setValue(header.key, forHTTPHeaderField: header.value)
        }
        if !(body is Void) {
            request.httpBody = try? encoder.encode(body)
        }
        printRequest(request)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            printResponse(response, data: data)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                    if let responseObject = try? decoder.decode(R.self, from: data) {
                        return .success(statusCode: httpResponse.statusCode, result: responseObject)
                    } else {
                        return .success(statusCode: httpResponse.statusCode, result: nil)
                    }
                } else {
                    return .error(statusCode: httpResponse.statusCode, error: nil, data: data)
                }
            }
            return .error(statusCode: -1, error: nil, data: nil)
        } catch {
            return .error(statusCode: -1, error: error, data: nil)
        }
    }
    
    private func printRequest(_ request: URLRequest) {
        #if DEBUG
        print("-----------------\n🌎 NETWORK REQUEST")
        var url = ""
        if let urlSafe = request.url {
            url = "\(urlSafe)"
        }
        print("\(url) - \(request.httpMethod ?? "")")
        if let body = request.httpBody {
            print("\(String(data: body, encoding: .utf8) ?? "")")
        }
        
        #endif
    }
    
    private func printResponse(_ response: URLResponse?, data: Data?) {
        #if DEBUG
        var icon = "🛑"
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        if statusCode >= 200 && statusCode < 300 {
            icon = "✅"
        }
        var url = ""
        if let urlSafe = response?.url {
            url = "\(urlSafe)"
        }
        print("-----------------\n\(icon) \(statusCode)\n\(String(url))")
        if let data = data {
            print("\(String(data: data, encoding: .utf8) ?? "")")
        }
        #endif
    }
}

struct Void: Codable { }

enum RequestResult<T: Codable> {
    case success(statusCode: Int, result: T?)
    case error(statusCode: Int, error: Error?, data: Data?)
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum RequestStatus {
    case idle
    case loading
    case error
}

