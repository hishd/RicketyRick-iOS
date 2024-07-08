//
//  LifeStatusContainer.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation
import UIKit

final class LifeStatusContainer: UIView {
    
    var characterStatus: CharacterStatus {
        didSet {
            switch characterStatus {
            case .alive:
                backgroundColor = .alive
                statusTitle.text = "Alive"
            case .dead:
                backgroundColor = .red
                statusTitle.text = "Dead"
            case .unknown:
                backgroundColor = .gray
                statusTitle.text = "Unknown"
            }
        }
    }
    
    lazy var statusTitle: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = .systemFont(ofSize: 10)
        return text
    }()
    
    init(characterStatus: CharacterStatus) {
        self.characterStatus = characterStatus
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setupView() {
        setDimensions(height: 26, width: 68)
        layer.cornerRadius = 10
        
        self.addSubview(statusTitle)
        statusTitle.center(inView: self)
    }
}
