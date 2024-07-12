//
//  ProductCollectionViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var stockStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AppThemeGreen")
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 0.9137255549, green: 0.9137254953, blue: 0.9137255549, alpha: 1)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    private var productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var storeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowOpacity = 10
        return image
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        let image = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "AppThemeGreen")
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .white
        addActionForFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 8
        
        addProductNameLabel()
        addProductImageView()
        addStockStatusLabel()
        addStoreImageView()
        addStoreNameLabel()
        addPriceLabel()
        addFavoriteButton()
    }
    
    private func addProductNameLabel() {
        contentView.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func addProductImageView() {
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 110),
            productImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func addStockStatusLabel() {
        contentView.addSubview(stockStatusLabel)
        NSLayoutConstraint.activate([
            stockStatusLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            stockStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            stockStatusLabel.widthAnchor.constraint(equalToConstant: 60),
            stockStatusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addStoreImageView() {
        contentView.addSubview(storeImageView)
        NSLayoutConstraint.activate([
            storeImageView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            storeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            storeImageView.widthAnchor.constraint(equalToConstant: 20),
            storeImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addStoreNameLabel() {
        contentView.addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor),
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 5),
            storeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func addPriceLabel() {
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    private func addFavoriteButton() {
        contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func addActionForFavoriteButton() {
        favoriteButton.addAction(UIAction(handler: { _ in
            print("Button tapped!")
        }), for: .touchUpInside)
    }
    
    
    func configure(with product: Product, storeName: String, storeImageUrl: String) {
        productNameLabel.text = product.name
        stockStatusLabel.text = product.stockStatus
        switch product.stockStatus {
        case "მარაგშია":
            stockStatusLabel.textColor = UIColor(named: "AppThemeGreen")
        case "მარაგი ამოიწურა":
            stockStatusLabel.textColor = UIColor.systemGray6
        case "მარაგი იწურება":
            stockStatusLabel.textColor = UIColor.orange
        default:
            stockStatusLabel.textColor = .gray
        }
        priceLabel.text = "\(product.price)₾"
        storeNameLabel.text = storeName
        
        if let url = URL(string: product.productImageURL) {
            productImageView.load(url: url)
        }
        
        if let storeUrl = URL(string: storeImageUrl) {
            storeImageView.load(url: storeUrl)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
