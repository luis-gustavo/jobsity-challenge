//
//  ImageCache.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class ImageCache {
  
  // MARK: - Properties
  private let lock = NSLock()
  private let config: Config
  
  private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.countLimit = config.countLimit
    return cache
  }()
  
  private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.totalCostLimit = config.memoryLimit
    return cache
  }()
  
  struct Config {
    let countLimit: Int
    let memoryLimit: Int
    
    static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
  }
  
  // MARK: - Inits
  init(config: Config = Config.defaultConfig) {
    self.config = config
  }
}

// MARK: - ImageCacheType Extension
extension ImageCache: ImageCacheType {
  func image(for url: URL) -> UIImage? {
    lock.lock(); defer { lock.unlock() }
    
    if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
        return decodedImage
    }
    // search for image data
    if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
        let decodedImage = image.decodedImage()
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
        return decodedImage
    }
    return nil
  }
  
  func insertImage(_ image: UIImage?, for url: URL) {
    guard let image = image else { return removeImage(for: url) }
    let decodedImage = image.decodedImage()
    
    lock.lock(); defer { lock.unlock() }
    
    imageCache.setObject(decodedImage, forKey: url as AnyObject)
    decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
  }
  
  func removeImage(for url: URL) {
    lock.lock(); defer { lock.unlock() }
    imageCache.removeObject(forKey: url as AnyObject)
    decodedImageCache.removeObject(forKey: url as AnyObject)
  }
  
  subscript(_ key: URL) -> UIImage? {
    get { return image(for: key) }
    set { return insertImage(newValue, for: key) }
  }
  
}
