import Foundation

struct Movie {
    var name: String
    var poster: String
    var genres: [Genre]
    var releaseDate: Date
    var overview: String
}

extension Movie: Equatable { }
func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.name == rhs.name
}
