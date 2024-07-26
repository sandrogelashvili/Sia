//
//  ProductListCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import UIKit

private enum Constants {
    static let productImageSize: CGFloat = 100
    static let stockStatusWidth: CGFloat = 90
    static let priceLabelFontSize: CGFloat = 14
    static let storeNameLabelFontSize: CGFloat = 12
    static let productNameLabelFontSize: CGFloat = 14
    static let stockStatusLabelFontSize: CGFloat = 10
    static let spacerViewWidth: CGFloat = 95
    
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
        imageView.layer.cornerRadius = Grid.CornerRadius.textField
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
        imageView.layer.cornerRadius = Grid.CornerRadius.textField
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
        label.layer.cornerRadius = Grid.CornerRadius.textField
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
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
        stackView.spacing = Grid.Spacing.xs3
        stackView.alignment = .leading
        return stackView
    }()
    
    private var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.priceLabelFontSize, weight: .medium)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private var newPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.priceLabelFontSize, weight: .medium)
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
        contentView.layer.cornerRadius = Grid.CornerRadius.textField
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = Grid.BorderWidth.thin
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
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Grid.Spacing.m),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Grid.Spacing.m),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Grid.Spacing.m)
        ])
    }
    
    private func addStockStatusLabel() {
        contentView.addSubview(stockStatusLabel)
        NSLayoutConstraint.activate([
            stockStatusLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            stockStatusLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: Grid.Spacing.xs2),
            stockStatusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.stockStatusWidth),
            stockStatusLabel.heightAnchor.constraint(equalToConstant: Grid.Spacing.l)
        ])
    }
    
    private func addStoreImageView() {
        contentView.addSubview(storeImageView)
        NSLayoutConstraint.activate([
            storeImageView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            storeImageView.topAnchor.constraint(equalTo: stockStatusLabel.bottomAnchor, constant: Grid.Spacing.xs2),
            storeImageView.widthAnchor.constraint(equalToConstant: Grid.Spacing.l),
            storeImageView.heightAnchor.constraint(equalToConstant: Grid.Spacing.l)
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
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: Grid.Spacing.xs2),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addPriceStackView() {
        contentView.addSubview(priceStackView)
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            priceStackView.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: Grid.Spacing.xs2),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Grid.Spacing.m)
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
            let attributedText = NSAttributedString(
                string: "\(product.price)₾",
                attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            oldPriceLabel.attributedText = attributedText
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
        case L10n.ProductCell.StockStatus.inStock:
            return UIColor .appThemeGreenUIKit
        case L10n.ProductCell.StockStatus.limitedStock:
            return .orange
        case L10n.ProductCell.StockStatus.outOfStock:
            return .gray
        default:
            return .gray
        }
    }
}
