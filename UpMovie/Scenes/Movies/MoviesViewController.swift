import UIKit

private let reuseIdentifier = "movieCell"

class MoviesViewController: UICollectionViewController, MoviesView {
    var presenter: MoviesPresenter!
    var configurator: MoviesConfigurator! = MoviesConfiguratorImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(moviesViewController: self)
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.presenter.router.prepare(for: segue, sender: sender)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        self.presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelect(row: indexPath.row)
    }
    
    // MARK: MoviesView
    func refreshMoviesView() {
        collectionView?.reloadData()
    }
    
    func displayMoviesError(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    // MARK: ScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.presenter.loadMore(scrollView)
    }

}
