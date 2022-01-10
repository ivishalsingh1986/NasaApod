//
//  UIImageView.swift
//  NasaApod
//
//  Created by Vishal on 8/1/2022.
//  This Extention is used to download the Image from the URL or Return the Cached Image for UIImageView

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        
        // Return the cached image if available
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x:self.frame.width/2,
                                           y: self.frame.height/2)
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
            self.addSubview(activityIndicator)
        }
        
        //Download image from Url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            if let error = error {
                debugPrint(error)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}

