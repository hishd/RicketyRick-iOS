//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cell_color")
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.15
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 4
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlaceholder
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var characterTitle: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 22, weight: .semibold)
        text.textColor = .black
        return text
    }()
    
    lazy var speciesContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "accessibility.fill")
        container.text.text = "Species"
        return container
    }()
    
    lazy var locationContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "mappin.circle.fill")
        container.text.text = "Location"
        return container
    }()
    
    lazy var episodesContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "tv.circle.fill")
        container.text.text = "Episodes"
        return container
    }()
    
    lazy var lifeStatusContainer: LifeStatusContainer = {
        let container = LifeStatusContainer(characterStatus: .unknown)
        return container
    }()
    
    static let reuseIdentifier = String(describing: CharacterCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.selectionStyle = .none
        self.contentView.addSubview(view)
        
        view.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 5,
            paddingLeft: 10,
            paddingBottom: 5,
            paddingRight: 10
        )
        
        view.addSubview(characterImageView)
        characterImageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            width: 132
        )
        
        view.addSubview(characterTitle)
        characterTitle.anchor(
            top: view.topAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 20
        )
        
        view.addSubview(speciesContainer)
        speciesContainer.anchor(
            top: characterTitle.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 20
        )
        
        view.addSubview(locationContainer)
        locationContainer.anchor(
            top: speciesContainer.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 20
        )
        
        view.addSubview(episodesContainer)
        episodesContainer.anchor(
            top: locationContainer.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 20
        )
        
        view.addSubview(lifeStatusContainer)
        lifeStatusContainer.centerYAnchor.constraint(equalTo: episodesContainer.centerYAnchor).isActive = true
        lifeStatusContainer.anchor(
            right: view.rightAnchor,
            paddingRight: 10
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
    }
}

class LifeStatusContainer: UIView {
    
    let characterStatus: CharacterStatus
    
    lazy var statusTitle: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = .systemFont(ofSize: 10)
        return text
    }()
    
    init(characterStatus: CharacterStatus) {
        self.characterStatus = characterStatus
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setupView() {
        setDimensions(height: 26, width: 68)
        layer.cornerRadius = 10
        
        switch characterStatus {
        case .alive:
            backgroundColor = .green
            statusTitle.text = "Alive"
        case .dead:
            backgroundColor = .red
            statusTitle.text = "Dead"
        case .unknown:
            backgroundColor = .gray
            statusTitle.text = "Unknown"
        }
        
        self.addSubview(statusTitle)
        statusTitle.center(inView: self)
    }
}

class DetailsContainerView: UIView {
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle.fill")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var text: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 16, weight: .regular)
        text.textColor = .black
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(icon)
        addSubview(text)
        
        icon.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            width: 18
        )
        
        text.anchor(
            top: self.topAnchor,
            left: icon.rightAnchor,
            bottom: self.bottomAnchor,
            paddingLeft: 8
        )
    }
}
