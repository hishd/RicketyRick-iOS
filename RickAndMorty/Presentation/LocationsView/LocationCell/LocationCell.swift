//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation
import UIKit

final class LocationCell: UITableViewCell {
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
    
    private lazy var locationTitle: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 22, weight: .semibold)
        text.textColor = .black
        return text
    }()
    
    private lazy var typeContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "star.circle.fill")
        container.textLabel.text = "Location Type"
        return container
    }()
    
    private lazy var dimensionContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "globe.desk.fill")
        container.textLabel.text = "Dimension"
        return container
    }()
    
    private lazy var characterContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "figure.2.circle.fill")
        container.textLabel.text = "Characters"
        return container
    }()
    
    static let reuseIdentifier = String(describing: LocationCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
    }
}

extension LocationCell {
    private func setupView() {
        self.selectionStyle = .none
        self.contentView.addSubview(view)
        
        view.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingLeft: 15,
            paddingRight: 10
        )
        
        view.addSubview(locationTitle)
        locationTitle.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(typeContainer)
        typeContainer.anchor(
            top: locationTitle.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(dimensionContainer)
        dimensionContainer.anchor(
            top: typeContainer.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(characterContainer)
        characterContainer.anchor(
            top: dimensionContainer.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 15,
            paddingRight: 5
        )
    }
    
    private func updateTitleMultiLine(isMultiline: Bool) {
        if isMultiline {
            self.locationTitle.numberOfLines = 2
//            self.locationTitle.font = .systemFont(ofSize: 18, weight: .semibold)
        } else {
            self.locationTitle.numberOfLines = 2
//            self.locationTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        }
    }
    
    func setData(episode: Episode?) {
        guard let episode = episode else {
            return
        }
        
        self.locationTitle.text = episode.episodeName
        self.typeContainer.textLabel.text = episode.fullCodeName
        self.dimensionContainer.textLabel.text = episode.airDate
        
        let characterCount = episode.characters.count
        self.characterContainer.textLabel.text = "\(characterCount) \(characterCount > 1 ? "Characters" : "Character")"
        
        updateTitleMultiLine(isMultiline: episode.episodeName.count > 30 )
    }
}
