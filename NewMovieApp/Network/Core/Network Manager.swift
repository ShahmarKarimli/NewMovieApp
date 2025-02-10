//
//  Network Manager.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import Foundation

class NetworkManager: TokenHelper {
    
    static let shared = NetworkManager()
    
    private var token: String? { retrieveToken()} /*"eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDI0ZDVjZjAxNWRlZjMyYTVkM2U1ZTlkMjBjNWI3OSIsIm5iZiI6MTczNDI1MTgyNi44MDcwMDAyLCJzdWIiOiI2NzVlOTUzMjIwNGYzYjViNDgzMDMyYzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.J8RHBQrJ8YaAKP9J9lSwAlhyqQMcgXseoOdgxg5RN6c"*/
    
    private init() {
        
      //  UserDefaultsHelper.setString("Kerimli_023", key: .accountId)
        
        UserDefaultsKeys.accountId.setString("Kerimli_023")
        _ = UserDefaultsKeys.accountId.getString()
        UserDefaultsKeys.accountId.remove()
        
        _ = saveTokens(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDI0ZDVjZjAxNWRlZjMyYTVkM2U1ZTlkMjBjNWI3OSIsIm5iZiI6MTczNDI1MTgyNi44MDcwMDAyLCJzdWIiOiI2NzVlOTUzMjIwNGYzYjViNDgzMDMyYzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.J8RHBQrJ8YaAKP9J9lSwAlhyqQMcgXseoOdgxg5RN6c")
    }
    
    func request<T>(model: NetworkRequestModel, completion: @escaping (NetworkResponse<T>) -> Void) {
        guard let urlRequest = getUrlRequest(model: model) else {return}
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            if let data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    print(String(decoding: jsonData, as: UTF8.self))
                } else {
                    print("json data malformed")
                }
                if let model = try? JSONDecoder().decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(.error(
                    CoreModel(success: false,
                    statusCode: httpResponse?.statusCode,
                    statusMessage: "")))
            }
        }).resume()
    }
    
    private func getUrlRequest(model: NetworkRequestModel) -> URLRequest? {
        guard let token, let url = URL(string: getPath(model: model)) else {return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.httpMethod = model.method.rawValue
        urlRequest.httpBody = model.body
        return urlRequest
    }
    
    private func getPath(model: NetworkRequestModel) -> String {
        var path = "https://api.themoviedb.org/3" + model.path
        if let pathParams = model.pathParams {
            for i in pathParams {
                path += "/\(i)"
            }
        }
        if let queryParams = model.queryParams, !queryParams.isEmpty {
            let query = queryParams.compactMap({
                guard let encodedValue = percentEncoding("\($0.value)") else {return nil}
                return "\($0.key)=\(encodedValue)"}).joined(separator: "&")
            path += "?\(query)"
        }
        return path
    }
    
    private func percentEncoding(_ value: String) -> String? {
        let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%"
        let characterSet = CharacterSet(charactersIn: string)
        return value.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
    
    static func getFullImagePath(filePath: String?) -> String? {
        guard let filePath else {return nil}
        let baseUrl = "https://image.tmdb.org/t/p/"
        let size = "w342"
        return "\(baseUrl)\(size)\(filePath)"
    }
}
