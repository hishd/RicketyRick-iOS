//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class EpisodeDetailView: UIView {
    let episode: Episode?
    
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
    
    private lazy var episodeCodeContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "info.circle.fill")
        container.title = "Code"
        container.text = episode?.fullCodeName
        container.setupView()
        return container
    }()
    
    private lazy var airDateContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "calendar.circle.fill")
        container.title = "Date"
        container.text = episode?.airDate
        container.setupView()
        return container
    }()
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var progressIndicator: ProgressView = ProgressView()
    
    init(episode: Episode?) {
        self.episode = episode
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init with a decoder not implemented")
    }
}

extension EpisodeDetailView {
    func setupView() {
        addSubview(titleInformation)
        titleInformation.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(episodeCodeContainer)
        episodeCodeContainer.anchor(
            top: titleInformation.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(airDateContainer)
        airDateContainer.anchor(
            top: episodeCodeContainer.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        addSubview(titleCharacters)
        titleCharacters.anchor(
            top: airDateContainer.bottomAnchor,
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
            paddingLeft: 20,
            paddingRight: 20
        )
                
        addSubview(progressIndicator)
        progressIndicator.attachedView = charactersTableView
        progressIndicator.center(inView: charactersTableView)
    }
}
