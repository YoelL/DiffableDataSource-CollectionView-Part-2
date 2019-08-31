//
//  UIImageViewEx.swift
//  DiffableDataSource CollectionView
//
//  Created by Yoel Lev on 31/08/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import UIKit

let cachedImages = NSCache<NSString, UIImage>()
extension UIImageView {
    
    //Fetch image profile from a URL Using URLSession and DispatchQueue main async
    func loadImageUsingCacheWithUrlString(urlString:String) {
        
        self.image = nil
    
        //Check cache for image first
        if let cacheImage = cachedImages.object(forKey: urlString as NSString)  {
            print("Fetching profile image from cache...")
            self.image = cacheImage
            return
        }
        
        //Otherwise fire off a new download
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data:data!){
                    cachedImages.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
        })
        task.resume()
    }
}
