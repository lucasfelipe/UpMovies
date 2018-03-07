import Foundation

struct ApiMovieResponse: InitWithDataProtocol, InitWithJSONProtocol {
    var page: Int
    var movies: [ApiMovie]
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
            throw NSError.createPraseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: Dictionary<String, Any>) throws {
        guard let page = json["page"] as? Int,
            let movies = json["results"] as? [[String: Any]]
            else { throw NSError.createPraseError() }
        self.page = page
        self.movies = try movies.map { try ApiMovie(json: $0) }
    }
}

struct ApiMovie: InitWithJSONProtocol {
    var name: String
    var poster: String
    var genre: [Int]
    var releaseDate: Date
    var overview: String
    
    init(json: Dictionary<String, Any>) throws {
        guard let name = json["title"] as? String,
            let releaseDate = Date.date(fromJSONString: json["release_date"] as? String),
            let overview = json["overview"] as? String else {
                throw NSError.createPraseError()
        }
        
        let poster = json["poster_path"] as? String
        let genres = json["genre_ids"] as? [Int]
        
        self.name = name
        self.poster = Constants.URL_IMAGE + (poster ?? "")
        self.genre = genres ?? [0]
        self.releaseDate = releaseDate
        self.overview = overview
    }
    
}

extension ApiMovie {
    var movie: Movie {
        return Movie(
            name: name,
            poster: poster,
            genres: genre.map { GenresSource.shared.findById($0) },
            releaseDate: releaseDate,
            overview: overview
        )
    }
}
