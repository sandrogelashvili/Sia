//
//  SectionHeaderView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import UIKit

private enum Constants {
    static let titleLabelFontSize: CGFloat = 18
    
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Grid.Spacing.m),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Grid.Spacing.m),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Grid.Spacing.xs),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Grid.Spacing.xs)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
