//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var searchBar: UITextField! {
        didSet { searchBar?.addDoneToolBar() }
    }
    
    var ingredientsArray = [String]()
    var recipes: RecipesInfo?
    var ingredientsListLogic = IngredientsListLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientsListUpdated), name: Notification.Name("update"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyAlert), name: Notification.Name("alert"), object: nil)
        
        // Do any additional setup after loading the view.
        ingredientsListLogic.clearList()
    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    @IBAction func addIngredientsButton(_ sender: Any) {
        searchBar.closeKeyboard()
        // First we're checking an ingredient is type to don't add an empty field to our URLRequest
        guard searchBar.text != "" else { return notifyAlert() }
        // Unwrapping searchBar.text
        guard let ingredient = searchBar.text else { return }
        
        ingredientsListLogic.addIngredient(ingredient)
    }
    
    @IBAction func clearListButton(_ sender: Any) {
        ingredientsListLogic.clearList()
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
        RecipeService().fetchRecipes(for: ingredientsListformatted()) { result in
            switch result {
            case .success(let recipes):
//                print(recipes)
                print(recipes.recipes.count)
                print(recipes.recipes.first!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func ingredientsListUpdated() {
        ingredientsList.text = ingredientsListLogic.ingredientsList
        searchBar.text = ingredientsListLogic.searchBar
        ingredientsArray = ingredientsListLogic.ingredientsArray
    }
    
    @objc func notifyAlert() {
        showAlert("Please add an ingredient", "It seems you forgot to add one 😉")
    }
    
}

