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
    
    private var productImageActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private var storeImageActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        label.backgroundColor = UIColor(#colorLiteral(red: 0.9098038077, green: 0.9098039269, blue: 0.9141095877, alpha: 1))
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .leading
        return stackView
    }()
    
    private var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private var newPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addProductImageActivityIndicator()
        addProductNameLabel()
        addStockStatusLabel()
        addStoreImageView()
        addStoreImageActivityIndicator()
        addStoreNameLabel()
        addPriceStackView()
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
    
    private func addProductImageActivityIndicator() {
        contentView.addSubview(productImageActivityIndicator)
        NSLayoutConstraint.activate([
            productImageActivityIndicator.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            productImageActivityIndicator.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor)
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
    
    private func addStoreImageActivityIndicator() {
        contentView.addSubview(storeImageActivityIndicator)
        NSLayoutConstraint.activate([
            storeImageActivityIndicator.centerXAnchor.constraint(equalTo: storeImageView.centerXAnchor),
            storeImageActivityIndicator.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addStoreNameLabel() {
        contentView.addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 4),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addPriceStackView() {
        contentView.addSubview(priceStackView)
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            priceStackView.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: 4),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
        priceStackView.addArrangedSubview(spacerView)
        
        spacerView.widthAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
    func configure(with product: Product, storeName: String, storeImageUrl: String) {
        productNameLabel.text = product.name
        stockStatusLabel.text = product.stockStatus
        stockStatusLabel.textColor = getColorForStockStatus(product.stockStatus)
        
        if product.onDeal == true, let newPrice = product.newPrice {
            oldPriceLabel.text = "\(product.price)₾"
            oldPriceLabel.isHidden = false
            newPriceLabel.text = "\(newPrice)₾"
        } else {
            oldPriceLabel.isHidden = true
            newPriceLabel.text = "\(product.price)₾"
        }
        
        loadImage(from: product.productImageURL, into: productImageView, with: productImageActivityIndicator)
        loadImage(from: storeImageUrl, into: storeImageView, with: storeImageActivityIndicator)
        
        storeNameLabel.text = storeName
    }
    
    private func loadImage(from urlString: String, into imageView: UIImageView, with activityIndicator: UIActivityIndicatorView) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            print("Invalid image URL: \(urlString)")
            return
        }
        activityIndicator.startAnimating()
        ImageLoader.shared.loadImage(from: url, into: imageView) {
            activityIndicator.stopAnimating()
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
