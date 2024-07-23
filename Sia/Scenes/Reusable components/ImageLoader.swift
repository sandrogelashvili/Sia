//
//  ImageLoader.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    func loadImage(from url: URL, into imageView: UIImageView, completion: @escaping () -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                completion()
            }
        }.resume()
    }
}
