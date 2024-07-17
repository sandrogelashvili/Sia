//
//  StoreCollectionViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 16.07.24.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "StoreCollectionViewCell"
    
    private var storeIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private var viewMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "მეტის ნახვა"
        label.textColor = .gray
        return label
    }()
    
    private var dealBannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 0.5
        return image
    }()
    
    private let topItemView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addStackView()
        addTopItemView()
        addStoreIconImage()
        addStoreNameLabel()
        addViewMoreLabel()
        addDealBannerImage()
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
        NSLayoutConstraint.activate([
            topItemView.heightAnchor.constraint(equalToConstant: 48),
            topItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func addStoreIconImage() {
        topItemView.addSubview(storeIconImage)
        NSLayoutConstraint.activate([
            storeIconImage.leadingAnchor.constraint(equalTo: topItemView.leadingAnchor, constant: 24),
            storeIconImage.centerYAnchor.constraint(equalTo: topItemView.centerYAnchor),
            storeIconImage.widthAnchor.constraint(equalToConstant: 32),
            storeIconImage.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func addStoreNameLabel() {
        topItemView.addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.leadingAnchor.constraint(equalTo: storeIconImage.trailingAnchor, constant: 11),
            storeNameLabel.centerYAnchor.constraint(equalTo: storeIconImage.centerYAnchor)
        ])
    }
    
    private func addViewMoreLabel() {
        topItemView.addSubview(viewMoreLabel)
        NSLayoutConstraint.activate([
            viewMoreLabel.trailingAnchor.constraint(equalTo: topItemView.trailingAnchor, constant: -24),
            viewMoreLabel.centerYAnchor.constraint(equalTo: storeIconImage.centerYAnchor)
        ])
    }
    
    private func addDealBannerImage() {
        stackView.addArrangedSubview(dealBannerImage)
        NSLayoutConstraint.activate([
            dealBannerImage.heightAnchor.constraint(equalToConstant: 165),
            dealBannerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dealBannerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with store: Store, dealBannerUrl: String) {
        storeNameLabel.text = store.name
        if let url = URL(string: store.storeImageURL) {
            loadImage(from: url, into: storeIconImage)
        }
        if let url = URL(string: dealBannerUrl) {
            loadImage(from: url, into: dealBannerImage)
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
