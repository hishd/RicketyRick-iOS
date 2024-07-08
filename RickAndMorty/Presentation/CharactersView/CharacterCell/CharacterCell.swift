//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit
import ImageLoader

final class CharacterCell: UITableViewCell {
    
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
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlaceholder
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var characterTitle: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 22, weight: .semibold)
        text.textColor = .black
        return text
    }()
    
    private lazy var speciesContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "accessibility.fill"))
        container.setText(with: "Species")
        return container
    }()
    
    private lazy var locationContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "mappin.circle.fill"))
        container.setText(with: "Location")
        return container
    }()
    
    private lazy var episodesContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "tv.circle.fill"))
        container.setText(with: "Episodes")
        return container
    }()
    
    private lazy var lifeStatusContainer: LifeStatusContainerView = {
        let container = LifeStatusContainerView(characterStatus: .unknown)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.characterImageView.image = nil
        self.characterImageView.cancelLoading()
    }
}

extension CharacterCell {
    private func setupView() {
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
            paddingLeft: 10,
            paddingRight: 5
        )
        
        view.addSubview(speciesContainer)
        speciesContainer.anchor(
            top: characterTitle.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 5
        )
        
        view.addSubview(locationContainer)
        locationContainer.anchor(
            top: speciesContainer.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 10,
            paddingRight: 5
        )
        
        view.addSubview(episodesContainer)
        episodesContainer.anchor(
            top: locationContainer.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 10,
            paddingRight: 5
        )
        
        view.addSubview(lifeStatusContainer)
        lifeStatusContainer.anchor(
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 10,
            paddingRight: 10
        )
    }
    
    private func updateTitleToMultiLine() {
        self.characterTitle.numberOfLines = 2
        self.characterTitle.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func setData(character: Character?) {
        guard let character = character else {
            return
        }
        
        self.characterTitle.text = character.characterName
        self.speciesContainer.setText(with: character.species)
        self.locationContainer.setText(with: character.lastLocation.locationName)
        self.lifeStatusContainer.characterStatus = character.status
        
        let episodeCount = character.episodes.count
        let episodeText = "\(episodeCount) \(episodeCount > 1 ? "Episodes" : "Episode")"
        self.episodesContainer.setText(with: episodeText)
        
        if character.characterName.count > 15 {
            updateTitleToMultiLine()
        }
        
        if let url = character.imageUrl {
            try? self.characterImageView.loadImage(from: url as NSURL, errorPlaceholderImage: .imgTitle)
        }
    }
}
