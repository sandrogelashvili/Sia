//
//  StoreDetailsTableViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import UIKit

private enum Constants {
    static let fontSize: CGFloat = 14
    
    enum ConstantsStrings {
        static let reuseIdentifier = "StoreDetailsTableViewCell"
    }
}

import UIKit

final class StoreDetailsTableViewCell: UITableViewCell {
    static let reuseIdentifier = Constants.ConstantsStrings.reuseIdentifier
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .semibold)
        return label
    }()
    
    private let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.StoreDetailsTableViewCell.mapButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Grid.Spacing.m
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(openingHoursLabel)
        stackView.addArrangedSubview(mapButton)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Grid.Spacing.l),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Grid.Spacing.l),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Grid.Spacing.s),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Grid.Spacing.s)
        ])
    }
    
    func configure(with location: Location, mapButtonAction: @escaping () -> Void) {
        locationLabel.text = location.address
        openingHoursLabel.text = location.openingHours
        mapButton.addAction(UIAction(handler: { _ in mapButtonAction() }), for: .touchUpInside)
    }
}
