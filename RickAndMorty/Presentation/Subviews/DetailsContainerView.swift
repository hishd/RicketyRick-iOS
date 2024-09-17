//
//  DetailsContainerView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation
import UIKit

final class DetailsContainerView: UIView {
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle.fill")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.numberOfLines = 2
        text.textColor = .cellText
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(icon)
        addSubview(textLabel)
        
        icon.setDimensions(height: 22, width: 22)
        icon.centerY(inView: self, leftAnchor: self.leftAnchor)
        
        textLabel.anchor(
            top: self.topAnchor,
            left: icon.rightAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingLeft: 8
        )
    }
    
    func setIconImage(with image: UIImage?) {
        self.icon.image = image
    }
    
    func setTextSize(of size: CGFloat) {
        self.textLabel.font = .systemFont(ofSize: size, weight: .regular)
    }
    
    func setText(with text: String?) {
        guard let text = text, !text.isEmpty else {
            self.textLabel.text = "Unknown"
            return
        }
        self.textLabel.text = text
    }
}
