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
    
    // MARK: - PROCESS FOR MEALS
    
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
    
    // MARK: - PROCESS FOR RECIPES
    
    private static func processFetchingRecipesDataFromLocal(completion: @escaping (Bool) -> Void) {
        let entities = CoreDataManager.shared.fetchAllRecipesEntities()
        
        for entity in entities {
            guard let entityName = entity.name else {
                continue
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            do {
                let results = try CoreDataManager.shared.viewContext.fetch(fetchRequest)
                
                if (results.count != 0) {
                    initRecipesDataFromLocal(with: [entityName: results])
                } else {
                    RecipesViewModel.setEmptyRecipesList(with: entityName)
                }
                
                print("Completed fetching data. Entity Name:" + AppConstants.whiteSpaceString + entityName + AppConstants.whiteSpaceString + "✅")
            } catch {
                print("Couldn't fetch data. Entity Name: \(String(describing: entityName)) \nReason: \(error.localizedDescription) ⛔")
                completion(false)
            }
        }
        
        completion(true)
    }
    
    private static func initRecipesDataFromLocal(with dictionary: Dictionary<String, [any NSFetchRequestResult]>) {
        let key = dictionary.keys.first
        let value = dictionary[key ?? AppConstants.emptyString]
        
        var recipesDetails: [RecipesDetailsModel] = Array()
        var ingredientsAndMeasures: [[String: [String: String]]] = Array()
        
        if let value = value {
            for entity in value {
                if let entity = entity as? NSManagedObject {
                    let details = RecipesViewModel.shared.initRecipesDetails(with: entity)
                    let ingAndMeas = processIngredientsAndMeasures(with: details)
                    
                    recipesDetails.append(details)
                    ingredientsAndMeasures.append(ingAndMeas)
                }
            }
        }
        
        RecipesViewModel.setRecipesData(with: key ?? AppConstants.emptyString, andWith: recipesDetails)
        RecipesViewModel.setIngredientsPerCategory(with: ingredientsAndMeasures)
    }
    
    private static func processIngredientsAndMeasures(with details: RecipesDetailsModel) -> [String: [String: String]] {
        let ingredients = details.strIngredientsDictionary
        let measures = details.strMeasuresDictionary
        
        var finalIngredients: [String: String] = Dictionary()
        
        for (key, ingVal) in ingredients {
            let ingIndex = key.last
            
            for (key, measVal) in measures {
                let measIndex = key.last
                
                if ingIndex == measIndex {
                    finalIngredients[ingVal] = measVal
                    break
                }
            }
        }
        
        return [String(details.idMeal): finalIngredients]
    }
    
    // MARK: - PROCESS FOR IMAGES
    
    static func fetchImageFromLocal(urlString: String) -> UIImage? {
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
    
    // MARK: - OTHERS
    
    private static func processFetchingAllDataFromLocal(completion: @escaping (Bool) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        var isDoneFetchingRecipes = false
        var isDoneFetchingMeals = false
        
        processFetchingMealsDataFromLocal { success in
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
            print("Completed fetching data. Elapsed time: \(elapsedTime.rounded())" + AppConstants.whiteSpaceString + "⌛")
            
            completion(true)
        }
    }
    
    static func searchMeal(in mealsData: [MealsDetailsModel]?, with searchText: String) -> [MealsDetailsModel]? {
        mealsData?.filter { $0.strMeal.localizedStandardContains(searchText) }
    }
    
    static func fetchMealsData() -> [MealsDetailsModel]? {
        let category = MealsViewModel.getMealCategory()
        let mealsData = MealsViewModel.getMealsData()
        
        return mealsData[category]
    }
    
    static func fetchRecipesData() -> [RecipesDetailsModel]? {
        let category = RecipesViewModel.getRecipeCategory()
        let recipeId = Int64(RecipesViewModel.getRecipeId())
        let recipesData = RecipesViewModel.getRecipesData()
        let ingredients = RecipesViewModel.getIngredients()
        
        let recipesPerCategory = recipesData[category]
        var filteredRecipes = recipesPerCategory?.filter { $0.idMeal == recipeId }
        
        let ingredientsPerCategory = ingredients[category]
        let filteredIngredients = ingredientsPerCategory?.filter { dictionary in
            dictionary.keys.contains(String(recipeId ?? 0))
        }
        
        if var details = filteredRecipes?.first {
            let dictionary = filteredIngredients?.first
            let key = String(recipeId ?? 0)
            let value = dictionary?[key]
            
            details.strIngredientsWithMeasures = value ?? [:]
            filteredRecipes?[0] = details
        }
        
        return filteredRecipes
    }
    
    static func checkEmptyRecipesData() -> Bool {
        let category = RecipesViewModel.getRecipeCategory()
        let emptyRecipesList = RecipesViewModel.getEmptyRecipesList()
        let isEmpty = emptyRecipesList.contains(category)
        
        return isEmpty
    }
}



