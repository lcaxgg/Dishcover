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
    private var mealsUrls: [String]? = Array()
    private var recipessUrls: [String: [String]]? = Dictionary()
    private var startTime: Double = 0.0
    
    private var isDoneFetchingRecipe: Bool = false
    private var isDoneFetchingMealsImages: Bool = false
    
    private let dispatchGroup: DispatchGroup = DispatchGroup()
    
    func fetchMealsDataFromServer(with mealsUrls: [String], completion: @escaping ([[String: [MealsDetails]]]?) -> Void) {
        DownloadManager.sharedInstance.startTime = Date().timeIntervalSince1970
        var urlListPerCategory = Array<String>()
        
        for url in mealsUrls {
            dispatchGroup.enter()
            
            AF.request(url).responseDecodable(of: MealsModel.self) { response in
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
                                DownloadManager.sharedInstance.mealsUrls?.append(details.strMealThumb ?? AppConstants.emptyString)
                                
                                let recipeUrl = ApiConstants.baseUrl + ApiConstants.recipePath + ApiConstants.recipeParam + details.idMeal
                                urlListPerCategory.append(recipeUrl)
                            }
                        }
                        
                        DownloadManager.sharedInstance.recipessUrls?[category] = urlListPerCategory
                        urlListPerCategory.removeAll()
                        
                        print("Couldn't fetch meal. Category:" + AppConstants.whiteSpace + category)
                    }
                    
                case .failure(let error):
                    print("Couldn't fetch meal. \(error.localizedDescription)")
                    return
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            fetchRecipesDataFromServer { done in
                DownloadManager.sharedInstance.isDoneFetchingRecipe = done
               
                if let response = processCompletion() {
                    if !response.isEmpty {
                        completion(response)
                    }
                }
            }
            
            fetchMealsImagesFromServer { meals in
                DownloadManager.sharedInstance.isDoneFetchingMealsImages = meals!.count > 0
            
                if let response = processCompletion() {
                    if !response.isEmpty {
                        completion(response)
                    }
                }
            }
        }
    }
        
    private func fetchRecipesDataFromServer(completion: @escaping (Bool) -> Void) {
        if let recipessUrls = DownloadManager.sharedInstance.recipessUrls {
            for urls in recipessUrls {
                let list = urls.value
                
                for url in list {
                    dispatchGroup.enter()
                    
                    AF.request(url)
                        .responseDecodable(of: RecipeModel.self) { response in
                            defer {
                                dispatchGroup.leave()
                            }
                            
                            switch response.result {
                                
                            case .success(let value):
                                print("Completed fetching recipe. Recipe: \(value.meals)")
                                
                            case .failure(let error):
                                print("Couldn't fetch recipe. \(error.localizedDescription)")
                                return
                            }
                        }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(true)
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
    
    private func fetchMealsImagesFromServer(completion: @escaping ([[String: [MealsDetails]]]?) -> Void) {
        if let mealsUrls = DownloadManager.sharedInstance.mealsUrls {
            for urlString in mealsUrls {
                let url = URL(string: urlString)!
                
                dispatchGroup.enter()
                
                AF.request(url).responseImage { response in
                    switch response.result {
                    case .success(let image):
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let imagesDirectory = documentsDirectory.appendingPathComponent(AppConstants.images)
                            
                            do {
                                if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
                                    try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
                                }
                                
                                let filename = url.lastPathComponent
                                let fileURL = imagesDirectory.appendingPathComponent(filename)
                                try imageData.write(to: fileURL)
                                
                                print("Completed saving image. Filename:" + AppConstants.whiteSpace + filename)
                            } catch {
                                print("Couldn't save image: \(error.localizedDescription)")
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
                completion(DownloadManager.sharedInstance.meals)
            }
        }
    }
    
    private func processCompletion() -> [[String: [MealsDetails]]]? {
        let isDoneFetchingRecipe = DownloadManager.sharedInstance.isDoneFetchingRecipe
        let isDoneFetchingMealsImages = DownloadManager.sharedInstance.isDoneFetchingMealsImages
        
        if isDoneFetchingRecipe && isDoneFetchingMealsImages {
            let endTime = Date().timeIntervalSince1970
            let elapsedTime = endTime - DownloadManager.sharedInstance.startTime
            print("Completed fetching data. Elapsed time: \(elapsedTime)")
            
            return DownloadManager.sharedInstance.meals
        }
        
        return []
    }
}
