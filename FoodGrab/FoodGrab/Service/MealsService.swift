//
//  MealsService.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation
import SwiftUI
import CoreData

struct MealsService {
    static func processMealsDataForDisplay(with mealsViewModel: MealsViewModel, completion: @escaping (Bool) -> Void) {
        let isEmptyRecord = CoreDataManager.sharedInstance.checkEmptyRecord()
        
        if isEmptyRecord {
            DownloadManager.sharedInstance.fetchMealsFromServer(with: ApiConstants.Url.mealsList) { responseObject in
                if responseObject != nil {
                    if let mealsCollection = responseObject {
                        for dictionary in mealsCollection {
                            initMealsData(with: dictionary, andWith: mealsViewModel)
                        }
                    }
                }
                
                completion(true)
            }
        } else {
            processFetchingMealsDataFromLocal(with: mealsViewModel) { success in
                completion(success)
            }
        }
    }
    
    private static func initMealsData(with dictionary: Dictionary<String, [MealsDetails]>, andWith mealsViewModel: MealsViewModel) {
        let key = dictionary.keys.first
        let values = dictionary[key ?? AppConstants.emptyString]
        
        mealsViewModel.mealsData[key ?? AppConstants.emptyString] = values
    }
    
    private static func processFetchingMealsDataFromLocal(with mealsViewModel: MealsViewModel, completion: @escaping (Bool) -> Void) {
        let entities = CoreDataManager.sharedInstance.fetchAllMealsEntities()
        
        for entity in entities {
            guard let entityName = entity.name else {
                continue
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            do {
                let results = try CoreDataManager.sharedInstance.viewContext.fetch(fetchRequest)
                
                for result in results {
                    if let managedObject = result as? NSManagedObject {
                        let key = managedObject.entity.name ?? AppConstants.emptyString
                        initMealsDataFromLocal(with: [key: results], andWith: mealsViewModel)
                    }
                }
                
                print("Completed fetching data. Entity Name:" + AppConstants.whiteSpace + entityName)
            } catch {
                print("* Couldn't fetch data. Entity Name: \(String(describing: entityName)) \nReason: \(error.localizedDescription) *")
                completion(false)
            }
        }
        
        completion(true)
    }
    
    private static func initMealsDataFromLocal(with dictionary: Dictionary<String, [any NSFetchRequestResult]>, andWith mealsViewModel: MealsViewModel) {
        let key = dictionary.keys.first
        let value = dictionary[key ?? AppConstants.emptyString]
        
        var mealsDetails: [MealsDetails] = Array()
        
        if let value = value {
            for entity in value {
                if let entity = entity as? NSManagedObject {
                    let details = mealsViewModel.initMealsDetails(with: entity)
                    mealsDetails.append(details)
                }
            }
        }
        
        mealsViewModel.mealsData[key ?? AppConstants.emptyString] = mealsDetails
    }
    
    static func fetchImageFromLocal(urlString: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let url = URL(string: urlString)!
        let imageDirectory = documentsDirectory.appendingPathComponent(AppConstants.images)
        let imageURL = imageDirectory.appendingPathComponent(url.lastPathComponent)
        
        guard FileManager.default.fileExists(atPath: imageURL.path) else {
            return nil
        }
        
        if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
            return image
        } else {
            return nil
        }
    }
    
    static func searchMeal(in mealsData: [MealsDetails]?, with searchText: String) -> [MealsDetails]? {
        mealsData?.filter { $0.strMeal.localizedStandardContains(searchText) }
    }
    
    static func fetchMealsData(per category: String, in mealsData: Dictionary<String, [MealsDetails]>?) -> [MealsDetails]? {
        mealsData?[category]
    }
}



