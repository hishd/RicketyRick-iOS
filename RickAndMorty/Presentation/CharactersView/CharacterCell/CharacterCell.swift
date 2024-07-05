//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
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
    
    static let reuseIdentifier = String(describing: CharacterCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
    }
}
