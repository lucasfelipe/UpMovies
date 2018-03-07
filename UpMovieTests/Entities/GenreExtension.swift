import Foundation
@testable import UpMovie

extension Genre {
    static func createAnArray(numberOfElements: Int = 2) -> [Genre] {
        var genres = [Genre]()
        
        for index in 0..<numberOfElements {
            let genre = createGenre(index)
            genres.append(genre)
        }
        return genres
    }
    
    static func createGenre(_ index: Int = 0) -> Genre {
        return Genre(id: index, name: "Name \(index)")
    }
}
