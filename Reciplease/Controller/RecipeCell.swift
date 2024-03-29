//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Manon Russo on 04/06/2021.
//
import UIKit

final class RecipeCell: UITableViewCell {
    // MARK: Properties
    private var recipeNameLabel = UILabel()
    private var ingredientsPreviewLabel = UILabel()
    private var cellBackgroundImage = UIImageView()
    private var timeAndYieldFrame = UIView()
    private var nameAndIngredientsStackView = UIStackView()
    private var extraInfoView = ExtraInfoView()
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureCell()
        extraInfoView.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        extraInfoView.configureView()
    }
    
    // MARK: Methods
    
    /// Adding space between cells.
    override func layoutSubviews() {
        super.layoutSubviews()
        /// Set the values for top, left, bottom and right margins' cell.
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    /// Set the values of the view with values of the recipe object.
    private func refreshData() {
//        guard let recipe = recipe else { return }
        extraInfoView.recipe = recipe
        recipeNameLabel.text = recipe?.name
        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
        /// Adding a default image while "real" one are loading.
        cellBackgroundImage.image = UIImage(named: "neutral_bg")

        if let image = recipe?.imageUrl { /// We first check we have an imageUrl, then we had it as background image.
            cellBackgroundImage.loadImage(image)
        } else { /// if we havn't' imageUrl, then we set a default image from asset as background pic.
            cellBackgroundImage.image = UIImage(named: "defaultRecipe")
            cellBackgroundImage.alpha = 0.55
        }
    }
    
    // MARK: - Setting constraints and displaying rules
    private func configureCell() {
        // MARK: BACKGROUND PIC
        cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundImage.alpha = 0.55
        cellBackgroundImage.contentMode = .scaleAspectFill
        contentView.addSubview(cellBackgroundImage)
        contentView.sendSubviewToBack(cellBackgroundImage)
        
        // MARK: RECIPE NAME
        recipeNameLabel.adjustsFontForContentSizeCategory = true
        recipeNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        recipeNameLabel.numberOfLines = 0
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: appliquer adjustFontForContentSizeCategory pour tous les textes
        
        // MARK: INGREDIENTS PREVIEW LABEL
        ingredientsPreviewLabel.adjustsFontForContentSizeCategory = true
        ingredientsPreviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        ingredientsPreviewLabel.numberOfLines = 2
        ingredientsPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: NAME AND INGREDIENTS STACKVIEW
        nameAndIngredientsStackView.distribution = UIStackView.Distribution.fillProportionally
        nameAndIngredientsStackView.alignment = UIStackView.Alignment.leading
        nameAndIngredientsStackView.spacing = 0
        nameAndIngredientsStackView.contentMode = .left
        nameAndIngredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndIngredientsStackView.axis = .vertical
        nameAndIngredientsStackView.addArrangedSubview(recipeNameLabel)
        nameAndIngredientsStackView.addArrangedSubview(ingredientsPreviewLabel)
        contentView.addSubview(nameAndIngredientsStackView)
        
        // MARK: ADDING EXTRA INFO VIEW
        extraInfoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extraInfoView)
                
        NSLayoutConstraint.activate([
            // MARK: Background image
            cellBackgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellBackgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellBackgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            // MARK: Name & Ingredients stack view
            nameAndIngredientsStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3.5),
            nameAndIngredientsStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2.5),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameAndIngredientsStackView.trailingAnchor, multiplier: 18),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: nameAndIngredientsStackView.bottomAnchor, multiplier: 2),
            
            // MARK: Extra info view
            extraInfoView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: extraInfoView.trailingAnchor, multiplier: 1),
            extraInfoView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: nameAndIngredientsStackView.trailingAnchor, multiplier: 10)
        ])
    }
    
}
