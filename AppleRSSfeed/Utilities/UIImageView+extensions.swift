//
//  UIImageView+extensions.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        DispatchQueue.global().async { [weak self] in
            
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), let image = UIImage(data: data) {
                        let cacheData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cacheData, for: request)
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
