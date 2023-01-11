//
//  ImageService.swift
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

final class ImageService {

    // MARK: - Public API

    func image(for URLString: String, completion: @escaping ImageClosure) -> Cancellable? {
        let fullURL = Constants.imageBaseURL + URLString
        let imageServerUrl = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: imageServerUrl as AnyObject) as? UIImage {

            completion(imageFromCache)
            return nil
        }

        guard let url = URL(string: imageServerUrl) else {
            completion(nil)
            return nil
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            // Helper
            var image: UIImage?

            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }

            if let data = data,
               let imageData = UIImage(data: data) {
                image = imageData
                imageCache.setObject(imageData, forKey: imageServerUrl as AnyObject)
            }
        }

        // Resume Data Task
        dataTask.resume()

        return dataTask
    }

}
