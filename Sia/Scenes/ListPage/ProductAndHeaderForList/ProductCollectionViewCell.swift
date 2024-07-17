//
//  ProductListCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCollectionViewCell"
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var stockStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor(#colorLiteral(red: 0.9098038077,
                                                      green: 0.9098039269,
                                                      blue: 0.9141095877,
                                                      alpha: 1))
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addProductImageView()
        addProductNameLabel()
        addStockStatusLabel()
        addStoreImageView()
        addStoreNameLabel()
        addPriceLabel()
    }
    
    private func addProductImageView() {
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addProductNameLabel() {
        contentView.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }
    
    private func addStockStatusLabel() {
        contentView.addSubview(stockStatusLabel)
        NSLayoutConstraint.activate([
            stockStatusLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            stockStatusLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            stockStatusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 90),
            stockStatusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addStoreImageView() {
        contentView.addSubview(storeImageView)
        NSLayoutConstraint.activate([
            storeImageView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            storeImageView.topAnchor.constraint(equalTo: stockStatusLabel.bottomAnchor, constant: 4),
            storeImageView.widthAnchor.constraint(equalToConstant: 20),
            storeImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addStoreNameLabel() {
        contentView.addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 4),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addPriceLabel() {
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func configure(with product: Product, storeName: String, storeImageUrl: String) {
        productNameLabel.text = product.name
        stockStatusLabel.text = product.stockStatus
        stockStatusLabel.textColor = getColorForStockStatus(product.stockStatus)
        priceLabel.text = "\(product.price)₾"
        
        if let url = URL(string: product.productImageURL), UIApplication.shared.canOpenURL(url) {
            loadImage(from: url, into: productImageView)
        } else {
            print("Invalid product image URL: \(product.productImageURL)")
        }
        
        storeNameLabel.text = storeName
        if let url = URL(string: storeImageUrl), UIApplication.shared.canOpenURL(url) {
            loadImage(from: url, into: storeImageView)
        } else {
            print("Invalid store image URL: \(storeImageUrl)")
        }
    }
    
    private func getColorForStockStatus(_ status: String) -> UIColor {
        switch status {
        case "მარაგშია":
            return UIColor(named: "AppThemeGreen") ?? .green
        case "მარაგი ამოიწურა":
            return .gray
        case "მარაგი იწურება":
            return .orange
        default:
            return .gray
        }
    }
}
