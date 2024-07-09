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
        view.backgroundColor = .cell
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
        text.textColor = .cellText
        return text
    }()
    
    private lazy var idContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "tv.circle.fill"))
        container.setText(with: "Episode ID")
        return container
    }()
    
    private lazy var dateContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "calendar.circle.fill"))
        container.setText(with:"Date")
        return container
    }()
    
    private lazy var characterContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "figure.2.circle.fill"))
        container.setText(with:"Characters")
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
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
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
            paddingLeft: 15,
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
//            self.episodeTitle.font = .systemFont(ofSize: 18, weight: .semibold)
        } else {
            self.episodeTitle.numberOfLines = 2
//            self.episodeTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        }
    }
    
    func setData(episode: Episode?) {
        guard let episode = episode else {
            return
        }
        
        self.episodeTitle.text = episode.episodeName
        self.idContainer.setText(with:episode.fullCodeName)
        self.dateContainer.setText(with:episode.airDate)
        
        let characterCount = episode.characters.count
        let characterText = "\(characterCount) \(characterCount > 1 ? "Characters" : "Character")"
        self.characterContainer.setText(with: characterText)
        
        updateTitleMultiLine(isMultiline: episode.episodeName.count > 30 )
    }
}
