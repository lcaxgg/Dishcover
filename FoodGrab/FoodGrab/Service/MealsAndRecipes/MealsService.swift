//
//  MealsService.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation
import CoreData

struct MealsService {
    static func processMealsDataForDisplay(completion: @escaping (Bool) -> Void) {
        let isEmptyRecord = CoreDataManager.shared.checkEmptyRecord()
        
        if isEmptyRecord {
            DownloadManager.shared.fetchMealsFromServer(with: ApiConstants.Url.mealsList) { responseObject in
                if responseObject != nil {
                    if let mealsCollection = responseObject {
                        for dictionary in mealsCollection {
                            initMealsData(with: dictionary)
                        }
                    }
                }
                
                completion(true)
            }
        } else {
            processFetchingAllDataFromLocal { success in
                completion(success)
            }
        }
    }
    
    private static func initMealsData(with dictionary: Dictionary<String, [MealsDetailsModel]>) {
        let key = dictionary.keys.first
        let values = dictionary[key ?? AppConstants.emptyString] ?? []
        
        MealsViewModel.setMealsData(with: key ?? AppConstants.emptyString, andWith: values)
    }
    
    private static func processFetchingMealsDataFromLocal(completion: @escaping (Bool) -> Void) {
        let entities = CoreDataManager.shared.fetchAllMealsEntities()
        
        for entity in entities {
            guard let entityName = entity.name else {
                continue
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            do {
                let results = try CoreDataManager.shared.viewContext.fetch(fetchRequest)
                
                for result in results {
                    if let managedObject = result as? NSManagedObject {
                        let key = managedObject.entity.name ?? AppConstants.emptyString
                        initMealsDataFromLocal(with: [key: results])
                    }
                }
                
                print("Completed fetching data. Entity Name:" + AppConstants.whiteSpaceString + entityName + AppConstants.whiteSpaceString + "✅")
            } catch {
                print("Couldn't fetch data. Entity Name: \(String(describing: entityName)) \nReason: \(error.localizedDescription) ⛔")
                completion(false)
            }
        }
        
        completion(true)
    }
    
    private static func initMealsDataFromLocal(with dictionary: Dictionary<String, [any NSFetchRequestResult]>) {
        let key = dictionary.keys.first
        let value = dictionary[key ?? AppConstants.emptyString]
        
        var mealsDetails: [MealsDetailsModel] = Array()
        
        if let value = value {
            for entity in value {
                if let entity = entity as? NSManagedObject {
                    let details = MealsViewModel.shared.initMealsDetails(with: entity)
                    mealsDetails.append(details)
                }
            }
        }
        
        MealsViewModel.setMealsData(with: key ?? AppConstants.emptyString, andWith: mealsDetails)
    }
    
    private static func processFetchingAllDataFromLocal(completion: @escaping (Bool) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        var isDoneFetchingRecipes = false
        var isDoneFetchingMeals = false
        
        processFetchingMealsDataFromLocal { success in
            if success {
                isDoneFetchingMeals = success
            }
        }
        
        RecipesService.processFetchingRecipesDataFromLocal { success in
            if success {
                isDoneFetchingRecipes = success
            }
        }
        
        if isDoneFetchingMeals && isDoneFetchingRecipes {
            let endTime = Date().timeIntervalSince1970
            let elapsedTime = endTime - startTime
            print("Completed fetching data. Elapsed time: \(elapsedTime.rounded())" + AppConstants.whiteSpaceString + "⌛")
            
            completion(true)
        }
    }
}



