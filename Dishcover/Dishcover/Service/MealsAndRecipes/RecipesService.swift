//
//  RecipesService.swift
//  Dishcover
//
//  Created by j8bok on 4/26/24.
//

import Foundation
import CoreData

struct RecipesService {
    static func processFetchingRecipesDataFromLocal(completion: @escaping (Bool) -> Void) {
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
}
