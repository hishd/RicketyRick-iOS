//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation
import UIKit

final class EpisodeCell: UITableViewCell {
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
    
    private lazy var episodeTitle: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 22, weight: .semibold)
        text.textColor = .black
        return text
    }()
    
    private lazy var idContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "tv.circle.fill")
        container.textLabel.text = "Episode ID"
        return container
    }()
    
    private lazy var dateContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "calendar.circle.fill")
        container.textLabel.text = "Date"
        return container
    }()
    
    private lazy var characterContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.icon.image = UIImage(systemName: "figure.2.circle.fill")
        container.textLabel.text = "Characters"
        return container
    }()
    
    static let reuseIdentifier = String(describing: EpisodeCell.self)
    
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
}

extension EpisodeCell {
    private func setupView() {
        self.selectionStyle = .none
        self.contentView.addSubview(view)
        
        view.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 5,
            paddingLeft: 15,
            paddingBottom: 5,
            paddingRight: 10
        )
        
        view.addSubview(episodeTitle)
        episodeTitle.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(idContainer)
        idContainer.anchor(
            top: episodeTitle.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(dateContainer)
        dateContainer.anchor(
            top: idContainer.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 15,
            paddingRight: 5
        )
        
        view.addSubview(characterContainer)
        characterContainer.anchor(
            top: dateContainer.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 15,
            paddingRight: 5
        )
    }
    
    private func updateTitleMultiLine(isMultiline: Bool) {
        if isMultiline {
            self.episodeTitle.numberOfLines = 2
            self.episodeTitle.font = .systemFont(ofSize: 18, weight: .semibold)
        } else {
            self.episodeTitle.numberOfLines = 2
            self.episodeTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        }
    }
    
    func setData(episode: Episode?) {
        guard let episode = episode else {
            return
        }
        
        self.episodeTitle.text = episode.episodeName
        self.idContainer.textLabel.text = episode.codeName
        self.dateContainer.textLabel.text = episode.airDate
        
        let characterCount = episode.characters.count
        self.characterContainer.textLabel.text = "\(characterCount) \(characterCount > 1 ? "Characters" : "Character")"
        
        updateTitleMultiLine(isMultiline: episode.episodeName.count > 30 )
    }
}
