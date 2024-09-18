//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class LocationDetailView: UIView {
    let location: Location?
    
    private lazy var titleInformation: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 22, weight: .medium)
        text.textColor = .cellText
        text.text = "Information"
        return text
    }()
    
    private lazy var titleCharacters: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 22, weight: .medium)
        text.textColor = .cellText
        text.text = "Characters"
        return text
    }()
    
    private lazy var locationTypeContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "star.circle.fill")
        container.title = "Type"
        container.text = location?.locationName
        container.setupView()
        return container
    }()
    
    private lazy var locationDimensionContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "globe.asia.australia.fill")
        container.title = "Dimension"
        container.text = location?.dimension
        container.setupView()
        return container
    }()
    
    lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var progressIndicator: ProgressView = ProgressView()
    
    init(location: Location?) {
        self.location = location
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init with a decoder not implemented")
    }
}

extension LocationDetailView {
    func setupView() {
        addSubview(titleInformation)
        titleInformation.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(locationTypeContainer)
        locationTypeContainer.anchor(
            top: titleInformation.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(locationDimensionContainer)
        locationDimensionContainer.anchor(
            top: locationTypeContainer.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(titleCharacters)
        titleCharacters.anchor(
            top: locationDimensionContainer.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 20,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(charactersTableView)
        charactersTableView.anchor(
            top: titleCharacters.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
                
        addSubview(progressIndicator)
        progressIndicator.attachedView = charactersTableView
        progressIndicator.center(inView: charactersTableView)
    }
}
