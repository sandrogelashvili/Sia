//
//  StoresPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 14.07.24.
//

import UIKit

final class StoresPageViewController: UIViewController {
    
    private var storesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "მაღაზიები"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setUpUI()
    }
    
    private func setUpUI() {
        addStoresTitleLabel()
    }
    
    private func addStoresTitleLabel() {
        view.addSubview(storesTitleLabel)
        NSLayoutConstraint.activate([
            storesTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            storesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

#Preview {
    StoresPageViewController()
}
