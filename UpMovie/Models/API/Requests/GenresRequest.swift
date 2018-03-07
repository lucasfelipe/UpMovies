import Foundation

struct GenresRequest: ApiRequest {
    private var params: [String: String] = [
        "api_key": Constants.API_KEY,
        "language": "en-US"
    ]
    
    var urlRequest: URLRequest {
        var components: URLComponents! = URLComponents(string: Constants.URL_GENRES)
        components.queryItems = params.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
