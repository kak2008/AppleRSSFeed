//
//  NetworkCommunicator.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

class NetworkCommunicator {
    static let shared = NetworkCommunicator()
    
    func getAlbumsData(completion: @escaping (_ albums: [Album]?, _ error: Error?) ->  Void) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/50/explicit.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            do {
                let album = try decoder.decode(AlbumsData.self, from: data)
                DispatchQueue.main.async {
                    completion(album.feed.results, nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
