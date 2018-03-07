import Foundation

class GenresSource {
    static let shared = GenresSource()
    private let gateway: GenreGateway
    private let fileName = "genres.plist"
    var genres: [Genre] = [Genre]()
    
    private init() {
        let apiClient = ApiClientImpl(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        self.gateway = ApiGenreGatewayImpl(with: apiClient)
    }
    
    func configure() {
        let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        let fullPathURL = url.appendingPathComponent(fileName)
        if (FileManager.default.fileExists(atPath: fullPathURL.absoluteString)) {
            readGenres(at: fullPathURL)
        } else {
            fetchGenres(completion: { (genres) in
                self.genres = genres
                self.writeGenres(at: fullPathURL)
            })
        }
    }
    
    func findById(_ id: Int) -> Genre {
        guard let genre = genres.filter ({ $0.id == id }).first else { return Genre(id: 0, name: "Unknown") }
        return genre
    }
    
    private func writeGenres(at path: URL) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(genres)
            encoder.outputFormat = .xml
            try data.write(to: path)
        } catch {
            return
        }
        
    }
    
    private func readGenres(at path: URL) {
        let decoder = PropertyListDecoder()
        guard let data = try? Data(contentsOf: path),
            let genres = try? decoder.decode([Genre].self, from: data) else { return }
        self.genres = genres
    }
    
    private func fetchGenres(completion: @escaping ([Genre]) -> Void) {
        self.gateway.fetchGenres { (result: Result<[Genre]>) in
            switch result {
            case .fail(_):
                return
            case let .success(genres):
                completion(genres)
            }
        }
    }
}
