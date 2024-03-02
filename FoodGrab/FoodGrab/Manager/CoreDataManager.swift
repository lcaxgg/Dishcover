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
        var isEmptyRecord: Bool = false
        let entities = viewContext.persistentStoreCoordinator?.managedObjectModel.entities
        
        for entity in entities ?? [] {
            let entityName = entity.name
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName ?? AppConstants.emptyString)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                
                if results.isEmpty {
                    isEmptyRecord.toggle()
                    break
                }
            } catch {
                print("Error fetching data for \(String(describing: entityName)): \(error.localizedDescription)")
            }
        }
        
        return isEmptyRecord
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func fetchAllMealsEntities() -> Array<NSEntityDescription> {
        viewContext.persistentStoreCoordinator?.managedObjectModel.entities ?? Array()
    }
    
    func fetchMealEntityForSaving(with key: String?) -> NSManagedObject? {
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
}
