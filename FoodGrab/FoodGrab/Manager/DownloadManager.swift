//
//  DownloadManager.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftUI

struct DownloadManager {
    static var sharedInstance = DownloadManager()
    
    private var meals: [[String: [MealsDetails]]] = Array()
    private var urlList: [String]? = Array()
    private var startTime: Double = 0.0
    
    func fetchMealsDataFromServer(with urls: [String], completion: @escaping ([[String: [MealsDetails]]]?) -> Void) {
        DownloadManager.sharedInstance.startTime = Date().timeIntervalSince1970
        let dispatchGroup = DispatchGroup()
        
        for url in urls {
            dispatchGroup.enter()
            
            AF.request(url)
                .responseDecodable(of: MealsModel.self) { response in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    switch response.result {
                        
                    case .success(let value):
                        if let range = url.range(of: AppConstants.equalString) {
                            let category = String(url[range.upperBound...])
                            
                            if let mealsForCategory = value.meals {
                                DownloadManager.sharedInstance.meals.append([category: mealsForCategory])
                                saveMealsDetailsLocally(with: category, andWith: mealsForCategory)
                                
                                for details in mealsForCategory {
                                    DownloadManager.sharedInstance.urlList?.append(details.strMealThumb ?? AppConstants.emptyString)
                                }
                            }
                        }
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                }
        }
        
        dispatchGroup.notify(queue: .main) {
            saveImageLocally { meals in
                completion(meals)
            }
        }
    }
    
    private func saveMealsDetailsLocally(with key: String, andWith mealsDetails: [MealsDetails]) {
        for detail in mealsDetails {
            let newEntity = CoreDataManager.sharedInstance.fetchMealEntityForSaving(with: key)
            
            newEntity?.setValue(Int64(detail.idMeal), forKey: AppConstants.idMealKey)
            newEntity?.setValue(detail.strMeal, forKey: AppConstants.strMealKey)
            newEntity?.setValue(detail.strMealThumb, forKey: AppConstants.strMealThumbKey)
            
            CoreDataManager.sharedInstance.save()
        }
    }
    
    private func saveImageLocally(completion: @escaping ([[String: [MealsDetails]]]?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        if let urlList = DownloadManager.sharedInstance.urlList {
            for urlString in urlList {
                let url = URL(string: urlString)!
                
                dispatchGroup.enter()
                
                AF.request(url).responseImage { response in
                    switch response.result {
                    case .success(let image):
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let imagesDirectory = documentsDirectory.appendingPathComponent("Images")
                            
                            do {
                                if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
                                    try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
                                }
                                
                                let filename = url.lastPathComponent
                                let fileURL = imagesDirectory.appendingPathComponent(filename)
                                try imageData.write(to: fileURL)
                            } catch {
                                print("Error saving image: \(error.localizedDescription)")
                            }
                        }
                        
                        dispatchGroup.leave()
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                let endTime = Date().timeIntervalSince1970
                let elapsedTime = endTime - DownloadManager.sharedInstance.startTime
                print("Saving Image Complete (elapsed time: \(elapsedTime))")
                
                completion(DownloadManager.sharedInstance.meals)
            }
        }
    }
}
