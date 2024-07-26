//
//  StoreCollectionViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 16.07.24.
//

import UIKit

protocol StoreCollectionViewCellDelegate: AnyObject {
    func didTapStoreCell(store: Store)
    func didTapBanner(for store: Store)
}

private enum Constants {
    static let storeNameLabelFontSize: CGFloat = 20
    static let viewMoreLabelFontSize: CGFloat = 14
    static let dealBannerHeight: CGFloat = 165
    static let dealBannerTextFontSize: CGFloat = 14
    
    enum ConstantsStrings {
        static let reuseIdentifier: String = "StoreCollectionViewCell"
    }
}

final class StoreCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.ConstantsStrings.reuseIdentifier
    
    weak var delegate: StoreCollectionViewCellDelegate?
    private var store: Store?
    
    private var storeIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = Grid.Spacing.m
        image.clipsToBounds = true
        return image
    }()
    
    private var storeIconActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.storeNameLabelFontSize, weight: .semibold)
        return label
    }()
    
    private var viewMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.viewMoreLabelFontSize)
        label.text = L10n.StoreCollectionViewCell.locations
        label.textColor = .gray
        return label
    }()
    
    private var dealBannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = Grid.CornerRadius.filter
        return image
    }()
    
    private var dealBannerActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let topItemView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = Grid.CornerRadius.filter
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = Grid.BorderWidth.thin
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Grid.Spacing.m
        stack.alignment = .fill
        return stack
    }()
    
    private let dealBannerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.dealBannerTextFontSize, weight: .bold)
        label.textColor = UIColor.white
        label.text = L10n.StoreCollectionViewCell.viewProducts
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
        contentView.backgroundColor = UIColor .gray400UIKit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addStackView()
        addTopItemView()
        addStoreIconImage()
        addStoreIconActivityIndicator()
        addStoreNameLabel()
        addViewMoreLabel()
        addDealBannerImage()
        addDealBannerActivityIndicator()
        addDealBannerTextLabel()
        addGradientToBanner()
    }
    
    private func addStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func addTopItemView() {
        stackView.addArrangedSubview(topItemView)
    }
    
    private func addStoreIconImage() {
        topItemView.addSubview(storeIconImage)
        NSLayoutConstraint.activate([
            storeIconImage.leadingAnchor.constraint(equalTo: topItemView.leadingAnchor, constant: Grid.Spacing.xl),
            storeIconImage.centerYAnchor.constraint(equalTo: topItemView.centerYAnchor),
            storeIconImage.widthAnchor.constraint(equalToConstant: Grid.Spacing.xl3),
            storeIconImage.heightAnchor.constraint(equalToConstant: Grid.Spacing.xl3)
        ])
    }
    
    private func addStoreIconActivityIndicator() {
        topItemView.addSubview(storeIconActivityIndicator)
        NSLayoutConstraint.activate([
            storeIconActivityIndicator.centerXAnchor.constraint(equalTo: storeIconImage.centerXAnchor),
            storeIconActivityIndicator.centerYAnchor.constraint(equalTo: storeIconImage.centerYAnchor)
        ])
    }
    
    private func addStoreNameLabel() {
        topItemView.addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.leadingAnchor.constraint(equalTo: storeIconImage.trailingAnchor, constant: Grid.Spacing.s),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeIconImage.centerYAnchor)
        ])
    }
    
    private func addViewMoreLabel() {
        topItemView.addSubview(viewMoreLabel)
        NSLayoutConstraint.activate([
            viewMoreLabel.trailingAnchor.constraint(equalTo: topItemView.trailingAnchor, constant: -Grid.Spacing.xl),
            viewMoreLabel.centerYAnchor.constraint(equalTo: storeIconImage.centerYAnchor)
        ])
    }
    
    private func addDealBannerImage() {
        stackView.addArrangedSubview(dealBannerImage)
        NSLayoutConstraint.activate([
            dealBannerImage.heightAnchor.constraint(equalToConstant: Constants.dealBannerHeight),
            dealBannerImage.topAnchor.constraint(equalTo: topItemView.bottomAnchor, constant: 80)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bannerTapped))
        dealBannerImage.addGestureRecognizer(tapGesture)
        dealBannerImage.isUserInteractionEnabled = true
    }
    
    private func addDealBannerActivityIndicator() {
        dealBannerImage.addSubview(dealBannerActivityIndicator)
        NSLayoutConstraint.activate([
            dealBannerActivityIndicator.centerXAnchor.constraint(equalTo: dealBannerImage.centerXAnchor),
            dealBannerActivityIndicator.centerYAnchor.constraint(equalTo: dealBannerImage.centerYAnchor)
        ])
    }
    
    private func addDealBannerTextLabel() {
        dealBannerImage.addSubview(dealBannerTextLabel)
        NSLayoutConstraint.activate([
            dealBannerTextLabel.bottomAnchor.constraint(equalTo: dealBannerImage.bottomAnchor, constant: -Grid.Spacing.xs),
            dealBannerTextLabel.trailingAnchor.constraint(equalTo: dealBannerImage.trailingAnchor, constant: -Grid.Spacing.xs)
        ])
    }
    
    private func addGradientToBanner() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = dealBannerImage.bounds
        dealBannerImage.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupActions() {
        topItemView.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self, let store = self.store else { return }
            self.delegate?.didTapStoreCell(store: store)
        }), for: .touchUpInside)
    }
    
    @objc private func bannerTapped() {
        guard let store = store else { return }
        delegate?.didTapBanner(for: store)
    }
    
    func configure(with store: Store, dealBannerUrl: String) {
        self.store = store
        storeNameLabel.text = store.name
        loadImage(from: store.storeImageURL, into: storeIconImage, with: storeIconActivityIndicator)
        loadImage(from: dealBannerUrl, into: dealBannerImage, with: dealBannerActivityIndicator)
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
}
