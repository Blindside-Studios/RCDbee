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
    private init() {}
    
    // TODO: This is public for debugging purposes, make private again
    public var cache: [String: UIImage] = [:]

    func getImage(forKey key: String) -> UIImage? {
        if let cachedImage = cache[key] {
            return cachedImage
        } else if let savedImage = loadFromDisk(forKey: key) {
            cache[key] = savedImage
            return savedImage
        }
        return nil
    }

    public func saveImage(_ image: UIImage, forKey key: String) {
        cache[key] = image
        saveToDisk(image, forKey: key)
    }

    private func loadFromDisk(forKey key: String) -> UIImage? {
        let fileURL = getFileURL(forKey: key)
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            return image
        }
        return nil
    }

    
    private func saveToDisk(_ image: UIImage, forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        
        // Send error message if conversion to JPEG fails
        guard let data = image.jpegData(compressionQuality: 1) else {
            debugPrint("Failed to convert UIImage to JPEG data.")
            return
        }
        // TODO: This might not always save correctly
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

    private func imageToUIImage(_ image: Image) -> UIImage? {
        let controller = UIHostingController(rootView: image)
        let view = controller.view

        let size = view!.intrinsicContentSize
        view!.bounds = CGRect(origin: .zero, size: size)
        view!.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
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
                }
            } catch {
                print("Could not clear disk cache: \(error)")
            }
        }
}
