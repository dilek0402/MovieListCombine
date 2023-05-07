//
//  ImageCache.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.04.2023.
//

import Foundation
import UIKit

public class ImageCache {
    
    // MARK: - Properties
    
    public static let publicCache = ImageCache()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?) -> Swift.Void]]()
    
    // MARK: - Methods
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        ImageURLProtocol.urlSession().dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
                  let blocks = self.loadingResponses[url], error == nil else {
                      DispatchQueue.main.async {
                          completion(nil)
                      }
                      return
                  }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
}
