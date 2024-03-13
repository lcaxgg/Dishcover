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
            processFetchingAllDataFromLocal { success in
                completion(success)
            }
        }
    }
    
    // MARK: - PROCESS FOR MEALS
    
    private static func initMealsData(with dictionary: Dictionary<String, [MealsDetailsModel]>, andWith mealsViewModel: MealsViewModel) {
        let key = dictionary.keys.first
        let values = dictionary[key ?? AppConstants.emptyString] ?? []
    
        MealsViewModel.setMealsData(with: key ?? AppConstants.emptyString, andWith: values)
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
        
        var mealsDetails: [MealsDetailsModel] = Array()
        
        if let value = value {
            for entity in value {
                if let entity = entity as? NSManagedObject {
                    let details = mealsViewModel.initMealsDetails(with: entity)
                    mealsDetails.append(details)
                }
            }
        }
        
        MealsViewModel.setMealsData(with: key ?? AppConstants.emptyString, andWith: mealsDetails)
    }

    // MARK: - PROCESS FOR RECIPES
    
    private static func processFetchingRecipesDataFromLocal(completion: @escaping (Bool) -> Void) {
        let entities = CoreDataManager.sharedInstance.fetchAllRecipesEntities()
        
        for entity in entities {
            guard let entityName = entity.name else {
                continue
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            do {
                let results = try CoreDataManager.sharedInstance.viewContext.fetch(fetchRequest)
                
                if (results.count != 0) {
                    initRecipesDataFromLocal(with: [entityName: results])
                }
                
                print("Completed fetching data. Entity Name:" + AppConstants.whiteSpace + entityName)
            } catch {
                print("* Couldn't fetch data. Entity Name: \(String(describing: entityName)) \nReason: \(error.localizedDescription) *")
                completion(false)
            }
        }
        
        completion(true)
    }
    
    private static func initRecipesDataFromLocal(with dictionary: Dictionary<String, [any NSFetchRequestResult]>) {
        let key = dictionary.keys.first
        let value = dictionary[key ?? AppConstants.emptyString]
        
        var recipesDetails: [RecipesDetailsModel] = Array()
        
        if let value = value {
            for entity in value {
                if let entity = entity as? NSManagedObject {
                    let details = RecipesViewModel.sharedInstance.initRecipesDetails(with: entity)
                    recipesDetails.append(details)
                }
            }
        }
        
        RecipesViewModel.setRecipesData(with: key ?? AppConstants.emptyString, andWith: recipesDetails)
    }
    
    // MARK: - PROCESS FOR IMAGES
    
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
    
    // MARK: - OTHERS
    
    private static func processFetchingAllDataFromLocal(completion: @escaping (Bool) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        var isDoneFetchingRecipes = false
        var isDoneFetchingMeals = false
        
        processFetchingMealsDataFromLocal(with: MealsViewModel.sharedInstance) { success in
            if success {
                isDoneFetchingMeals = success
            }
        }
        
        processFetchingRecipesDataFromLocal { success in
            if success {
                isDoneFetchingRecipes = success
            }
        }
        
        if isDoneFetchingMeals && isDoneFetchingRecipes {
            let endTime = Date().timeIntervalSince1970
            let elapsedTime = endTime - startTime
            print("Completed fetching data. Elapsed time: \(elapsedTime.rounded())")
            
            completion(true)
        }
    }
    
    static func searchMeal(in mealsData: [MealsDetailsModel]?, with searchText: String) -> [MealsDetailsModel]? {
        mealsData?.filter { $0.strMeal.localizedStandardContains(searchText) }
    }
    
    static func fetchMealsData() -> [MealsDetailsModel]? {
        let category = MealsViewModel.sharedInstance.getMealCategory()
        let mealsData = MealsViewModel.sharedInstance.getMealsData()
        
        return mealsData[category]
    }
}



