import UIKit

extension UIImage {
    static func imageFromURL(string: String) -> UIImage? {
        guard let imageURL = URL(string: string),
              let imageData = try? Data(contentsOf: imageURL) else { return nil }
        
        return UIImage(data: imageData)
    }
}
