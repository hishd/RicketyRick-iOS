//
//  ProgressView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-06.
//

import Foundation
import UIKit

final class ProgressView: UIView {
    
    private var isAnimating: Bool = false
    var attachedView: UIView?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.stopAnimating()
        return indicator
    }()
    
    private lazy var title: UILabel = {
        let text = UILabel()
        text.text = "Loading!"
        text.font = .systemFont(ofSize: 15)
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
        self.alpha = 0
        self.setDimensions(height: 80, width: 80)
//        self.backgroundColor = .lightGray
//        self.layer.cornerRadius = 10
        
        self.addSubview(activityIndicator)
        activityIndicator.center(inView: self)
        
        self.addSubview(title)
        title.centerX(inView: self, topAnchor: activityIndicator.bottomAnchor, paddingTop: 6)
    }
    
    func startAnimating() {
        guard !isAnimating else {
            return
        }
        
        if let view = attachedView {
            UIView.animate(withDuration: 0.75) {
                view.alpha = 0
            }
        }
        
        self.isAnimating = true
        self.activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.alpha = 1
        }
    }
    
    func stopAnimating() {
        guard isAnimating else {
            return
        }
        
        if let view = attachedView {
            UIView.animate(withDuration: 0.75) {
                view.alpha = 1
            }
        }
        
        self.isAnimating = false
        self.activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.alpha = 0
        }
    }
}
