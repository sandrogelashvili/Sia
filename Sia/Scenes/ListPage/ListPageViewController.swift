//
//  ListPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 12.07.24.
//

import UIKit

final class ListPageViewController: UIViewController {
    
    private var listTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "სია"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("სიის გასუფთავება", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setUpUI()
        addActionForClearButton()
    }
    
    private func setUpUI() {
        addListTitleLabel()
        addClearButton()
    }
    
    private func addListTitleLabel() {
        view.addSubview(listTitleLabel)
        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func addClearButton() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    private func addActionForClearButton() {
        clearButton.addAction(UIAction(handler: { _ in
            print("Button tapped!")
        }), for: .touchUpInside)
    }
}


#Preview {
    ListPageViewController()
}
