import Foundation
@testable import UpMovie

extension Movie {
    static func createAnArray(numberOfElements: Int = 2) -> [Movie] {
        var movies = [Movie]()
        
        for index in 0..<numberOfElements {
            let movie = createMovie(index)
            movies.append(movie)
        }
        
        return movies
    }
    
    static func createMovie(_ index: Int = 0) -> Movie {
        return Movie(
            name: "Name \(index)",
            poster: "https://www.w3schools.com/w3css/img_fjords.jpg",
            genres: [Genre(id: index, name: "Genre \(index)")],
            releaseDate: Calendar.current.startOfDay(for: Date()),
            overview: "overview"
        )
    }
}
