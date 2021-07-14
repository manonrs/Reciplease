//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 13/07/2021.
//
import CoreData
import XCTest
@testable import Reciplease

class CoreDataTests: XCTestCase {
    var storageService: StorageService!
    
    override func setUp() {
        super.setUp()
        // MARK: - managedObjectModel
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        // MARK: - persistentStoreDescription
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true
        
        // MARK: - persistentContainer
        let persistentContainer = NSPersistentContainer(name: "Reciplease", managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        
        storageService = StorageService(persistentContainer: persistentContainer)
        
    }
    
    override func tearDown() {
        storageService = nil
        super.tearDown()
    }
    
    func testRecipeLoading() {
        let recipe = FakeResponseData.recipe.first!
        let recipe2 = FakeResponseData.recipe[1]
        let recipe3 = FakeResponseData.recipe[2]
        var loadedRecipes: [Recipe] = [recipe, recipe2, recipe3]
        // faire une boucle for each recipes
        for recipe in loadedRecipes {
            do {
                try storageService.saveRecipe(recipe)
            } catch {
                XCTFail("error saving \(error.localizedDescription)")
            }
            do {
                loadedRecipes = try storageService.loadRecipes()
            } catch {
                XCTFail("error loading \(error.localizedDescription)")
            }
            //            XCTAssertFalse(loadedRecipes.isEmpty, "")
            //            XCTAssertTrue(loadedRecipes.count == 3)
            //            XCTAssertTrue(((loadedRecipes.first?.name) != nil), "The Crispy Egg")
            //            XCTAssertTrue((loadedRecipes[1].name) == "Egg Noodle")
        }
        XCTAssertFalse(loadedRecipes.isEmpty)
        XCTAssertTrue(loadedRecipes.count == 3)
        XCTAssertTrue(loadedRecipes.first?.name == "Egg Noodle")
        XCTAssertTrue((loadedRecipes[1].name) == "The Crispy Egg")
        XCTAssertFalse(loadedRecipes[1].name.isEmpty)
        
        //tableau.count = le bon nombre de recettes, première recette avec le nom
    }
    func testRecipeDeletion() {
        let recipe = FakeResponseData.recipe.first!
        let recipe2 = FakeResponseData.recipe[1]
        let recipe3 = FakeResponseData.recipe[2]
 

        var loadedRecipes: [Recipe] = [recipe, recipe2, recipe3]

        for recipe in loadedRecipes {
            do {
                try storageService.saveRecipe(recipe)
            } catch {
                XCTFail("error saving \(error.localizedDescription)")
            }
            do {
                try storageService.deleteRecipe(recipe)
            } catch {
                XCTFail("error deleting \(error.localizedDescription)")
            }
            
            do {
               loadedRecipes = try storageService.loadRecipes()
            } catch {
                XCTFail("error loading \(error.localizedDescription)")
            }
    //        XCTAssertTrue(loadedRecipes.isEmpty)
            XCTAssertTrue(loadedRecipes.count == 0)
        }

    }
    
}
