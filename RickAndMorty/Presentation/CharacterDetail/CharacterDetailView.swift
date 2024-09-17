//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-17.
//

import Foundation
import UIKit

final class CharacterDetailView: UIView {
    
    private let character: Character?
    private let imageViewSize: CGFloat = 140
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.image = .imgPlaceholder
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var characterInformationView: CharacterInformationView = {
        let view = CharacterInformationView(character: self.character)
        view.setupView()
        return view
    }()
    
    init(character: Character?) {
        self.character = character
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init from coder not implemented")
    }
        
    func setConstraints() {
        addSubview(characterImageView)
        characterImageView.centerX(
            inView: self,
            topAnchor: self.safeAreaLayoutGuide.topAnchor,
            paddingTop: 10
        )
        characterImageView.setDimensions(height: imageViewSize, width: imageViewSize)
        characterImageView.layer.cornerRadius = imageViewSize / 2
        
        addSubview(characterInformationView)
        characterInformationView.anchor(
            top: self.characterImageView.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        
        if let imageUrl = self.character?.imageUrl {
            try? characterImageView.loadImage(from: imageUrl as NSURL, errorPlaceholderImage: .imgTitle)
        }
    }
}
