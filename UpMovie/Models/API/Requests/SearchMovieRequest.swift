import Foundation

struct SearchMovieRequest: ApiRequest {
    private var params: [String: String] = [
        "api_key": Constants.API_KEY,
        "language": "en-US",
        "include_adult": "false"
    ]
    
    init(with name: String) {
        params["query"] = name
    }
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: Constants.URL_SEARCH)!
        urlComponents.queryItems = params.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
