//
//  SectionHeaderView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import UIKit

private enum Constants {
    static let titleLabelFontSize: CGFloat = 18
    static let titleLabelLeadingPadding: CGFloat = 16
    static let titleLabelTrailingPadding: CGFloat = -16
    static let titleLabelTopPadding: CGFloat = 8
    static let titleLabelBottomPadding: CGFloat = -8
    
    enum ConstantsStrings {
        static let cellIdentifier: String = "HeaderView"
    }
}

final class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = Constants.ConstantsStrings.cellIdentifier
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.titleLabelTrailingPadding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopPadding),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.titleLabelBottomPadding)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
