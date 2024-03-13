//
//  CoreDataManager.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - PROPERTIES
    
    static var sharedInstance = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    // MARK: - COMPUTED PROPERTY
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - METHODS
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MealsDataModel")
        
        let fileManager = FileManager.default
        let appSupportDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDataDirectory = appSupportDirectory.appendingPathComponent("CoreData", isDirectory: true)

        do {
            try fileManager.createDirectory(at: appDataDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("Error creating Core Data directory: \(error)")
        }
        
        let storeURL = appDataDirectory.appendingPathComponent("MealsDataModel.sqlite")

        let description = NSPersistentStoreDescription(url: storeURL)
        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("\(error.localizedDescription)")
            } else {
                print("Core Data loaded successfully")
            }
        }
    }
    
    func checkEmptyRecord() -> Bool {
        var isEmptyRecord: Bool = true
        let entities = viewContext.persistentStoreCoordinator?.managedObjectModel.entities
        
        for entity in entities ?? [] {
            let entityName = entity.name
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName ?? AppConstants.emptyString)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                
                if !results.isEmpty {
                    isEmptyRecord.toggle()
                    break
                }
            } catch {
                print("Error fetching data for \(String(describing: entityName)): \(error.localizedDescription)")
            }
        }
        
        return isEmptyRecord
    }

    func fetchAllMealsEntities() -> Array<NSEntityDescription> {
        let mealsEntities = viewContext.persistentStoreCoordinator?.managedObjectModel.entities ?? Array()
        let filteredMealEntities = mealsEntities.filter { !$0.name!.contains(AppConstants.underScoreString) }
        
        return filteredMealEntities
    }
    
    private func fetchMealEntity(with key: String?) -> NSManagedObject? {
        var entity: NSManagedObject? = nil
        
        if let newKey = MealsCategoriesEnum.fromString(key ?? AppConstants.emptyString) {
            switch newKey {
            case .beef:
                entity = Beef(context: viewContext)
            case .chicken:
                entity = Chicken(context: viewContext)
            case .dessert:
                entity = Dessert(context: viewContext)
            case .lamb:
                entity = Lamb(context: viewContext)
            case .miscellaneous:
                entity = Miscellaneous(context: viewContext)
            case .pasta:
                entity = Pasta(context: viewContext)
            case .pork:
                entity = Pork(context: viewContext)
            case .seafood:
                entity = Seafood(context: viewContext)
            case .side:
                entity = Side(context: viewContext)
            case .starter:
                entity = Starter(context: viewContext)
            case .vegan:
                entity = Vegan(context: viewContext)
            case .vegetarian:
                entity = Vegetarian(context: viewContext)
            case .breakfast:
                entity = Breakfast(context: viewContext)
            case .goat:
                entity = Goat(context: viewContext)
            }
        }
        
        return entity
    }
    
    func fetchAllRecipesEntities() -> Array<NSEntityDescription> {
        let recipesEntities = viewContext.persistentStoreCoordinator?.managedObjectModel.entities ?? Array()
        let filteredRecipesEntities = recipesEntities.filter { $0.name!.contains(AppConstants.underScoreString) }
        
        return filteredRecipesEntities
    }
    
    private func fetchRecipeEntity(with key: String?) -> NSManagedObject? {
        var entity: NSManagedObject? = nil
        
        if let newKey = RecipesEnum.fromString(key ?? AppConstants.emptyString) {
            switch newKey {
            case .beef_recipe:
                entity = Beef_Recipe(context: viewContext)
            case .chicken_recipe:
                entity = Chicken_Recipe(context: viewContext)
            case .dessert_recipe:
                entity = Dessert_Recipe(context: viewContext)
            case .lamb_recipe:
                entity = Lamb_Recipe(context: viewContext)
            case .miscellaneous_recipe:
                entity = Miscellaneous_Recipe(context: viewContext)
            case .pasta_recipe:
                entity = Pasta_Recipe(context: viewContext)
            case .pork_recipe:
                entity = Pork_Recipe(context: viewContext)
            case .seafood_recipe:
                entity = Seafood_Recipe(context: viewContext)
            case .side_recipe:
                entity = Side_Recipe(context: viewContext)
            case .starter_recipe:
                entity = Starter_Recipe(context: viewContext)
            case .vegan_recipe:
                entity = Vegan_Recipe(context: viewContext)
            case .vegetarian_recipe:
                entity = Vegetarian_Recipe(context: viewContext)
            case .breakfast_recipe:
                entity = Breakfast_Recipe(context: viewContext)
            case .goat_recipe:
                entity = Goat_Recipe(context: viewContext)
            }
        }
        
        return entity
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func setMealDetails(with mealsDetails: MealsDetails, andWith entityKey: String) {
        let mealsViewModel = MealsViewModel()
        mealsViewModel.setMealsDetails(with: mealsDetails)
        
        let entity = fetchMealEntity(with: entityKey)
        
        entity?.setValue(mealsViewModel.getIdMeal(), forKey: AppConstants.idMeal)
        entity?.setValue(mealsViewModel.getStrMeal(), forKey: AppConstants.strMeal)
        entity?.setValue(mealsViewModel.getStrMealThumb(), forKey: AppConstants.strMealThumb)
        
        save()
    }
    
    func setRecipeDetails(with recipeDetails: Dictionary<String, String?>?, andWith entityKey: String) {
        let recipesViewModel = RecipesViewModel()
        recipesViewModel.setRecipesDetails(with: recipeDetails)
        
        let entity = fetchRecipeEntity(with: entityKey)
        
        entity?.setValue(recipesViewModel.getIdMeal(), forKey: AppConstants.idMeal)
        entity?.setValue(recipesViewModel.getStrMeal(), forKey: AppConstants.strMeal)
        entity?.setValue(recipesViewModel.getStrCategory(), forKey: AppConstants.strCategory)
        entity?.setValue(recipesViewModel.getStrIngredients(), forKey: AppConstants.strIngredients)
        entity?.setValue(recipesViewModel.getStrMeasures(), forKey: AppConstants.strMeasures)
        entity?.setValue(recipesViewModel.getStrInstructions(), forKey: AppConstants.strInstructions)
        entity?.setValue(recipesViewModel.getStrMealThumb(), forKey: AppConstants.strMealThumb)
        entity?.setValue(recipesViewModel.getStrYoutube(), forKey: AppConstants.strYoutube)
        
        save()
    }
}
