//
//  StoreHeaderView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import UIKit

class HeaderView: UICollectionReusableView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var locationLabels: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(storeName: String, locationNames: [String]) {
        titleLabel.text = storeName
        
        // Remove existing location labels
        locationLabels.forEach { $0.removeFromSuperview() }
        locationLabels.removeAll()
        
        // Add new location labels
        var previousLabel: UILabel? = titleLabel
        for locationName in locationNames {
            let locationLabel = UILabel()
            locationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            locationLabel.translatesAutoresizingMaskIntoConstraints = false
            locationLabel.text = locationName
            addSubview(locationLabel)
            NSLayoutConstraint.activate([
                locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                locationLabel.topAnchor.constraint(equalTo: previousLabel!.bottomAnchor, constant: 5)
            ])
            previousLabel = locationLabel
            locationLabels.append(locationLabel)
        }
    }
}
