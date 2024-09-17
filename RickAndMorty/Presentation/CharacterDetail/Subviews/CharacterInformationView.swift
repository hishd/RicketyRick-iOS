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

fileprivate final class InformationContainerItem: UIView {
    var title: String?
    var text: String?
    var iconImage: UIImage?
    
    private lazy var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.setDimensions(height: 24, width: 24)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cellText
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.setDimensions(height: 25, width: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cellText
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .cell
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not implemented")
    }
    
    func setupView() {
        self.addSubview(imageIcon)
        self.imageIcon.image = iconImage
        imageIcon.centerY(
            inView: self,
            leftAnchor: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: 10
        )
        
        self.addSubview(titleLabel)
        self.titleLabel.text = title
        titleLabel.centerY(
            inView: self,
            leftAnchor: imageIcon.rightAnchor,
            paddingLeft: 6
        )
        
        self.addSubview(separatorView)
        separatorView.centerY(
            inView: self,
            leftAnchor: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: 110
        )
        
        self.addSubview(textLabel)
        self.textLabel.text = text
        textLabel.centerY(
            inView: self,
            leftAnchor: self.separatorView.rightAnchor,
            paddingLeft: 14
        )
        
        let height: CGFloat = text?.count ?? 40 < 40 ? 40 : 60
        self.setHeight(of: height)
    }
}

@available(iOS 17.0, *)
#Preview {
    let view = CharacterInformationView(character: .sample)
    view.setupView()
    return view
}
