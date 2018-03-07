import UIKit

class DetailMovieViewController: UIViewController, DetailMovieView {
    //MARK: IBOutlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    
    var configurator: DetailMovieConfigurator!
    var presenter: DetailMoviePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(detailMovieViewController: self)
        self.presenter.viewDidLoad()
    }
    
    func display(name: String) {
        self.name.text = name
    }
    
    func display(poster: UIImage?) {
        self.poster.image = poster
    }

    func display(genres: String) {
        self.genres.text = genres
    }
    
    func display(overview: String) {
        self.overview.text = overview
    }
    
    func display(releaseDate: String) {
        self.releaseDate.text = releaseDate
    }
}
