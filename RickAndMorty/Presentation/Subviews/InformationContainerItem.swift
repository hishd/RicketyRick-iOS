//
//  InformationContainerItem.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class InformationContainerItem: UIView {
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
