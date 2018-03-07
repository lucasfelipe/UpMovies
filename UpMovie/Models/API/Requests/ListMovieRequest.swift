import Foundation

struct ListMovieRequest: ApiRequest {
    private var params: [String: String] = [
        "api_key": Constants.API_KEY,
        "language": "en-US",
        "include_adult": "false",
        "include_video": "false",
        "page": "1"
    ]
    
    init(with page: Int) {
        self.params["release_date.gte"] = Date.string(from: Date())
        self.params["page"] = "\(page)"
    }
    
    var urlRequest: URLRequest {
        var components: URLComponents! = URLComponents(string: Constants.URL_DISCOVER)
        components.queryItems = params.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
