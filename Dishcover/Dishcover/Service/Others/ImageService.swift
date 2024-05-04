//
//  ImageService.swift
//  Dishcover
//
//  Created by j8bok on 4/26/24.
//

import Foundation
import SwiftUI

struct ImageService {
    static func getImageFromLocal(urlString: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let url = URL(string: urlString)
        let imageDirectory = documentsDirectory.appendingPathComponent(AppConstants.images)
        let imageURL = imageDirectory.appendingPathComponent(url?.lastPathComponent ?? AppConstants.emptyString)
        
        guard FileManager.default.fileExists(atPath: imageURL.path) else {
            return nil
        }
        
        if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
            return image
        } else {
            return nil
        }
    }
}
