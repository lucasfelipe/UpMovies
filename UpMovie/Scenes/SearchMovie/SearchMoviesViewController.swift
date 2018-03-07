import UIKit

private let reuseIdentifier = "movieTableViewCell"

class SearchMoviesViewController: UITableViewController, SearchMovieView, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    var presenter: SearchMoviePresenter!
    var configurator: SearchMovieConfigurator = SearchMovieConfiguratorImpl()
    var searchController: UISearchController!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(searchMoviesViewController: self)
        self.configurator.configureSearchBarController(self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfMovies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchMovieTableViewCell
        
        self.presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelect(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Search Movie View
    func refreshSearchMoviesView() {
        self.tableView.reloadData()
    }
    
    func displaySearchMoviesError(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    // MARK: Search Bar Methods
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        guard let name = searchController.searchBar.text, name.count >= 3 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.searchMovie(by: name)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let _ = self.timer, let name = searchBar.text else { return }
        self.presenter.searchMovie(by: name)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.presenter.router.prepare(for: segue, sender: sender)
    }
}
