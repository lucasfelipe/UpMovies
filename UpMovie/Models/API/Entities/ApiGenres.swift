import Foundation

struct ApiGenreResponse: InitWithDataProtocol, InitWithJSONProtocol {
    var genres: [ApiGenre]
    
    init(data: Data?) throws {
        guard let data = data,
        let jsonObject = try? JSONSerialization.jsonObject(with: data),
        let json = jsonObject as? [String: Any] else {
            throw NSError.createPraseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: Dictionary<String, Any>) throws {
        guard let genres = json["genres"] as? [[String: Any]]
            else { throw NSError.createPraseError() }
        
        self.genres = try genres.map { try ApiGenre(json: $0) }
    }
}

struct ApiGenre: InitWithJSONProtocol {
    var id: Int
    var name: String
    
    init(json: Dictionary<String, Any>) throws {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            else {
                throw NSError.createPraseError()
        }
        
        self.id = id
        self.name = name
    }
    
}

extension ApiGenre {
    var genre: Genre {
        return Genre(id: id, name: name)
    }
}
