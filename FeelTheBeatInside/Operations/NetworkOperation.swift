//
//  SearchArtistOperation.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 21/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class NetworkOperation: NSObject {
    
    static func search(query: String, completion: @escaping () -> ()) {
        
        let urlString = "https://api.spotify.com/v1/search?q=\(query)&type=artist".replacingOccurrences(of: " ", with: "%20").folding(options: .diacriticInsensitive, locale: .current)
        
        let weakUrl = URL(string: urlString)
        
        guard let url = weakUrl else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(AccessControllManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion()
        }

        task.resume()
    }
    
}
