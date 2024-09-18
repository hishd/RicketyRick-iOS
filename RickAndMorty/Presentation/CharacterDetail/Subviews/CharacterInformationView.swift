//
//  CharacterInformationView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-17.
//

import Foundation
import UIKit
import SwiftUI

final class CharacterInformationView: UIView {
    private var character: Character?
    
    private lazy var title: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 22, weight: .medium)
        text.textColor = .cellText
        text.text = "Information"
        return text
    }()
    
    private lazy var scrollView: UIScrollView = .init()
    
    private lazy var scrollContainer: UIView = .init()
    
    private lazy var statusContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "heart.circle.fill")
        container.title = "Status"
        container.text = switch character?.status {
        case .alive:
            "Alive"
        case .dead:
            "Dead"
        default:
            "Unknown"
        }
        container.setupView()
        return container
    }()
    
    private lazy var speciesContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "accessibility.fill")
        container.title = "Species"
        container.text = character?.species
        container.setupView()
        return container
    }()
    
    private lazy var genderContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "arrow.up.right.circle.fill")
        container.title = "Gender"
        container.text = character?.gender
        container.setupView()
        return container
    }()
    
    private lazy var originContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "globe.asia.australia.fill")
        container.title = "Origin"
        container.text = character?.origin.originName
        container.setupView()
        return container
    }()
    
    private lazy var locationContainer: InformationContainerItem = {
        let container = InformationContainerItem()
        container.iconImage = UIImage(systemName: "location.circle.fill")
        container.title = "Location"
        container.text = character?.lastLocation.locationName
        container.setupView()
        return container
    }()
    
    init(character: Character?) {
        self.character = character
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.addSubview(title)
        
        title.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor
        )
        
        self.addSubview(scrollView)

        scrollView.anchor(
            top: title.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            height: 200
        )

        scrollContainer.addSubview(statusContainer)
        scrollContainer.addSubview(speciesContainer)
        scrollContainer.addSubview(genderContainer)
        scrollContainer.addSubview(originContainer)
        scrollContainer.addSubview(locationContainer)
        
        statusContainer.anchor(
            top: scrollContainer.safeAreaLayoutGuide.topAnchor,
            left: scrollContainer.safeAreaLayoutGuide.leftAnchor,
            right: scrollContainer.safeAreaLayoutGuide.rightAnchor
        )
        
        speciesContainer.anchor(
            top: statusContainer.bottomAnchor,
            left: scrollContainer.safeAreaLayoutGuide.leftAnchor,
            right: scrollContainer.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6
        )
        
        genderContainer.anchor(
            top: speciesContainer.bottomAnchor,
            left: scrollContainer.safeAreaLayoutGuide.leftAnchor,
            right: scrollContainer.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6
        )
        
        originContainer.anchor(
            top: genderContainer.bottomAnchor,
            left: scrollContainer.safeAreaLayoutGuide.leftAnchor,
            right: scrollContainer.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6
        )
        
        locationContainer.anchor(
            top: originContainer.bottomAnchor,
            left: scrollContainer.safeAreaLayoutGuide.leftAnchor,
            right: scrollContainer.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6
        )
        
        scrollView.addSubview(scrollContainer)
        
        scrollContainer.anchor(
            top: scrollView.contentLayoutGuide.topAnchor,
            left: scrollView.contentLayoutGuide.leftAnchor,
            bottom: scrollView.contentLayoutGuide.bottomAnchor,
            right: scrollView.contentLayoutGuide.rightAnchor,
            paddingTop: 16,
            height: 240
        )
        
        scrollContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
    }
}

@available(iOS 17.0, *)
#Preview {
    let view = CharacterInformationView(character: .sample)
    view.setupView()
    return view
}
