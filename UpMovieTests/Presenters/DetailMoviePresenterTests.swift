import XCTest
@testable import UpMovie

class DetailMoviePresenterTests: XCTestCase {
    let detailMovieViewSpy = DetailMovieViewSpy()
    
    var detailMoviePresenter: DetailMoviePresenterImpl!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        movie = Movie.createAnArray(numberOfElements: 1)[0]
        self.detailMoviePresenter = DetailMoviePresenterImpl(view: detailMovieViewSpy,
                                                             movie: movie)
        
    }
    
    func testDetailPresenterViewDidLoadShouldDisplayMovieData() {
        let expectedMovieName = movie.name
        let expectedMovieGenres = movie.genres.map { "\($0.name)" }.joined(separator: ", ")
        let expectedMovieReleaseDate = Date.string(from: movie.releaseDate)
        let expectedMoviePoster = UIImage.imageFromURL(string: movie.poster)
        let expectedMovieOverview = movie.overview
        
        self.detailMoviePresenter.viewDidLoad()
        
        XCTAssertEqual(expectedMovieName, self.detailMovieViewSpy.name, "Name must to be equal")
        XCTAssertEqual(expectedMovieGenres, self.detailMovieViewSpy.genres, "Genres must to be equal")
        XCTAssertEqual(expectedMovieReleaseDate, self.detailMovieViewSpy.releaseDate, "Release Date must to be equal")
        XCTAssertEqual(UIImageJPEGRepresentation(expectedMoviePoster!, 0.0), UIImageJPEGRepresentation(detailMovieViewSpy.poster!, 0.0), "Poster must to be equal")
        XCTAssertEqual(expectedMovieOverview, self.detailMovieViewSpy.overview, "Overview must to be equal")
        
    }
}
