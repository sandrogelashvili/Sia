//
//  ProductListCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import UIKit

private enum Constants {
    static let productImageCornerRadius: CGFloat = 8
    static let productImageSize: CGFloat = 100
    static let productImageLeadingPadding: CGFloat = 16
    static let productImageTrailingPadding: CGFloat = 16
    static let productNameTopPadding: CGFloat = 16
    static let stockStatusTopPadding: CGFloat = 4
    static let stockStatusWidth: CGFloat = 90
    static let stockStatusHeight: CGFloat = 20
    static let storeImageTopPadding: CGFloat = 4
    static let storeImageSize: CGFloat = 20
    static let storeNameLeadingPadding: CGFloat = 4
    static let priceStackViewTopPadding: CGFloat = 4
    static let priceStackViewBottomPadding: CGFloat = -16
    static let priceStackViewSpacing: CGFloat = 2
    static let oldPriceLabelFontSize: CGFloat = 14
    static let newPriceLabelFontSize: CGFloat = 14
    static let storeNameLabelFontSize: CGFloat = 12
    static let productNameLabelFontSize: CGFloat = 14
    static let stockStatusLabelFontSize: CGFloat = 10
    static let spacerViewWidth: CGFloat = 95
    static let contentViewCornerRadius: CGFloat = 10
    static let contentViewBorderWidth: CGFloat = 0.5
    
    enum ConstantsStrings {
        static let cellIdentifier: String = "ProductCollectionViewCell"
    }
}

final class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.ConstantsStrings.cellIdentifier
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.productImageCornerRadius
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
        imageView.layer.cornerRadius = Constants.productImageCornerRadius
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
        label.font = UIFont.systemFont(ofSize: Constants.productNameLabelFontSize, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var stockStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.stockStatusLabelFontSize, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .gray400UIKit
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.storeNameLabelFontSize, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constants.priceStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.oldPriceLabelFontSize, weight: .medium)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private var newPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.newPriceLabelFontSize, weight: .medium)
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
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = Constants.contentViewBorderWidth
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
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Grid.Spacing.m),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: Constants.productImageSize),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.productImageSize)
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
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.productImageTrailingPadding),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.productImageTrailingPadding),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.productNameTopPadding)
        ])
    }
    
    private func addStockStatusLabel() {
        contentView.addSubview(stockStatusLabel)
        NSLayoutConstraint.activate([
            stockStatusLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            stockStatusLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: Constants.stockStatusTopPadding),
            stockStatusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.stockStatusWidth),
            stockStatusLabel.heightAnchor.constraint(equalToConstant: Constants.stockStatusHeight)
        ])
    }
    
    private func addStoreImageView() {
        contentView.addSubview(storeImageView)
        NSLayoutConstraint.activate([
            storeImageView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            storeImageView.topAnchor.constraint(equalTo: stockStatusLabel.bottomAnchor, constant: Constants.storeImageTopPadding),
            storeImageView.widthAnchor.constraint(equalToConstant: Constants.storeImageSize),
            storeImageView.heightAnchor.constraint(equalToConstant: Constants.storeImageSize)
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
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: Constants.storeNameLeadingPadding),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addPriceStackView() {
        contentView.addSubview(priceStackView)
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            priceStackView.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: Constants.priceStackViewTopPadding),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.priceStackViewBottomPadding)
        ])
        
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
        priceStackView.addArrangedSubview(spacerView)
        
        spacerView.widthAnchor.constraint(equalToConstant: Constants.spacerViewWidth).isActive = true
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
        case L10n.Productcell.Stockstatus.inStock:
            return UIColor .appThemeGreenUIKit
        case L10n.Productcell.Stockstatus.limitedStock:
            return .gray
        case L10n.Productcell.Stockstatus.outOfStock:
            return .orange
        default:
            return .gray
        }
    }
}
