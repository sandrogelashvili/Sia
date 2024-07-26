//
//  StoreDetailsHeaderView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import UIKit
import Combine

private enum Constants {
    static let nameLabelFontSize: CGFloat = 22
    static let nameLabelLeadingPadding: CGFloat = 20
}

final class StoreDetailsHeaderView: UIView {
    private var cancellables = Set<AnyCancellable>()
    
    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Grid.CornerRadius.filter
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let storeImageActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize, weight: .semibold)
        return label
    }()
    
    init(viewModel: StoreDetailsViewModel) {
        super.init(frame: .zero)
        setupUI()
        bindViewModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addStoreImageView()
        addStoreImageActivityIndicator()
        addStoreNameLabel()
    }
    
    private func addStoreImageView() {
        addSubview(storeImageView)
        NSLayoutConstraint.activate([
            storeImageView.topAnchor.constraint(equalTo: topAnchor, constant: Grid.Spacing.l),
            storeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Grid.Spacing.l),
            storeImageView.widthAnchor.constraint(equalToConstant:Grid.Spacing.xl3),
            storeImageView.heightAnchor.constraint(equalToConstant:Grid.Spacing.xl3)
        ])
    }
    
    private func addStoreImageActivityIndicator() {
        addSubview(storeImageActivityIndicator)
        NSLayoutConstraint.activate([
            storeImageActivityIndicator.centerXAnchor.constraint(equalTo: storeImageView.centerXAnchor),
            storeImageActivityIndicator.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor)
        ])
    }
    
    private func addStoreNameLabel() {
        addSubview(storeNameLabel)
        NSLayoutConstraint.activate([
            storeNameLabel.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor),
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: Constants.nameLabelLeadingPadding),
            storeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Grid.Spacing.l)
        ])
    }
    
    private func bindViewModel(_ viewModel: StoreDetailsViewModel) {
        viewModel.$storeImageURL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                guard let self = self else { return }
                if let url = URL(string: url) {
                    self.storeImageActivityIndicator.startAnimating()
                    ImageLoader.shared.loadImage(from: url, into: self.storeImageView) {
                        self.storeImageActivityIndicator.stopAnimating()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.$storeName
            .receive(on: DispatchQueue.main)
            .sink { [weak storeNameLabel] name in
                storeNameLabel?.text = name
            }
            .store(in: &cancellables)
    }
}
