//
//  ImageCache.swift
//  RCDbee
//
//  Created by Blindside on 27.10.24.
//

import Foundation
import UIKit
import SwiftUICore
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private init() {
        loadKeys()
    }
    
    private var cache: [String: UIImage] = [:]
    private var keys: [String] = [] // keeping track of saved image order
    private let limit = 100
    private let userDefaultsKey = "cachedImageKeys"
    
    
    
    func getImage(forKey key: String) -> UIImage? {
        if let cachedImage = cache[key] {
            return cachedImage
        } else if let savedImage = loadFromDisk(forKey: key) {
            cache[key] = savedImage
            return savedImage
        }
        return nil
    }
    
    private func loadFromDisk(forKey key: String) -> UIImage? {
        let fileURL = getFileURL(forKey: key)
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    
    
    
    public func saveImage(_ image: UIImage, forKey key: String) {
        if cache.count >= limit {
            // Remove the oldest image
            if let oldestKey = keys.first {
                cache.removeValue(forKey: oldestKey)
                removeImageFromDisk(forKey: oldestKey)
                keys.removeFirst()
            }
        }
        
        cache[key] = image
        keys.append(key)
        saveToDisk(image, forKey: key)
        saveKeys()
    }
    
    private func saveToDisk(_ image: UIImage, forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        
        guard let data = image.jpegData(compressionQuality: 1) else {
            debugPrint("Failed to convert UIImage to JPEG data.")
            return
        }
        do {
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            debugPrint("Error saving image to \(fileURL): \(error.localizedDescription)")
        }
    }
    
    private func getFileURL(forKey key: String) -> URL {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(key + ".jpeg")
    }
    
    
    
    
    private func removeImageFromDisk(forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            debugPrint("Failed to remove image from disk: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        cache.removeAll()
        clearDiskCache()
    }
    
    private func clearDiskCache() {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
                keys.removeAll()
                saveKeys()
            }
        } catch {
            print("Could not clear disk cache: \(error)")
        }
        
    }
    
    
    private func loadKeys() {
        if let savedKeys = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
                keys = savedKeys
        }
    }

    private func saveKeys() {
        UserDefaults.standard.set(keys, forKey: userDefaultsKey)
    }
}
