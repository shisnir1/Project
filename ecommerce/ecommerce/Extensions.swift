

import Foundation
import UIKit
extension UIImageView {
    func setImageFromURL(ImageURL: String) {
        URLSession.shared.dataTask(with: URL(string: ImageURL)!) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
}
