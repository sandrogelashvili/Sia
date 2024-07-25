//
//  StoreDetailsTableViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import UIKit

private enum StoreDetailsTableViewCellConstants {
    static let locationLabelFontSize: CGFloat = 14
    static let openingHoursLabelFontSize: CGFloat = 14
    static let openingHoursLabelTextColor: UIColor = .gray
    static let mapButtonFontSize: CGFloat = 12
    static let stackViewSpacing: CGFloat = 16
    static let stackViewLeadingPadding: CGFloat = 20
    static let stackViewTrailingPadding: CGFloat = -20
    static let stackViewTopPadding: CGFloat = 10
    static let stackViewBottomPadding: CGFloat = -10
}

import UIKit

final class StoreDetailsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "StoreDetailsTableViewCell"
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: StoreDetailsTableViewCellConstants.locationLabelFontSize, weight: .semibold)
        return label
    }()
    
    private let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: StoreDetailsTableViewCellConstants.openingHoursLabelFontSize, weight: .medium)
        label.textColor = StoreDetailsTableViewCellConstants.openingHoursLabelTextColor
        label.textAlignment = .center
        return label
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Storedetailstableviewcell.mapButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: StoreDetailsTableViewCellConstants.mapButtonFontSize)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = StoreDetailsTableViewCellConstants.stackViewSpacing
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
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StoreDetailsTableViewCellConstants.stackViewLeadingPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: StoreDetailsTableViewCellConstants.stackViewTrailingPadding),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: StoreDetailsTableViewCellConstants.stackViewTopPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: StoreDetailsTableViewCellConstants.stackViewBottomPadding)
        ])
    }
    
    func configure(with location: Location, mapButtonAction: @escaping () -> Void) {
        locationLabel.text = location.address
        openingHoursLabel.text = location.openingHours
        mapButton.addAction(UIAction(handler: { _ in mapButtonAction() }), for: .touchUpInside)
    }
}
