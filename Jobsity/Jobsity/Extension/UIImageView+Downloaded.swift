//
//  UIImageView+Downloaded.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

fileprivate let cache = ImageCache()

extension UIImageView {
    
    func downloaded(from url: URL) {
        if let image = cache[url] {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            cache[url] = image
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
