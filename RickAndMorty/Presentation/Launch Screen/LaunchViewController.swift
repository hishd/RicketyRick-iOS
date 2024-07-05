//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-04.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation
import OSLog

class LaunchViewController: UIViewController, Presentable {
    var viewModel: (any ViewModel)?
    weak var coordinator: RootCoordinator?
    private var soundEffect: AVAudioPlayer?
    
    lazy var titleImage: UIImageView = {
        let imageView = UIImageView(image: .imgTitle)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var portalImage: UIImageView = {
        let imageView = UIImageView(image: .imgPortal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var rickImage: UIImageView = {
        let imageView = UIImageView(image: .imgRick)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var mortyImage: UIImageView = {
        let imageView = UIImageView(image: .imgMorty)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setResources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
    
    static func create(with viewModel: (any ViewModel)?) -> LaunchViewController {
        let viewController = LaunchViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        view.backgroundColor = UIColor(named: "bg_dark")
        view.addSubview(titleImage)
        
        titleImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 20,
            paddingRight: 20,
            height: 180
        )
        
        view.addSubview(portalImage)
        portalImage.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: -50,
            paddingBottom: -50,
            paddingRight: -50,
            height: 400
        )
        
        view.addSubview(rickImage)
        rickImage.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            width: 250,
            height: 440
        )
        
        view.addSubview(mortyImage)
        mortyImage.anchor(
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            width: 170,
            height: 210
        )
    }
    
    deinit {
        print("Deinit.....!!!!!")
    }
}

extension LaunchViewController {
    func setResources() {
        guard let filePath = Bundle.main.path(forResource: "sound_track", ofType: "mp3") else {
            Logger.viewCycle.error("Audio file not found")
            return
        }
        
        let url: URL = .init(fileURLWithPath: filePath)
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.setVolume(0.03, fadeDuration: 0.2)
            soundEffect?.play()
        } catch {
            Logger.viewCycle.error("Error: \(error)")
        }
    }
    
    func animateViews() {
        titleImage.center.y = titleImage.center.y - (view.bounds.height/2)
        portalImage.transform = CGAffineTransform(scaleX: 0, y: 0)
        portalImage.alpha = 0
        rickImage.center.x = rickImage.center.x - view.bounds.width/2
        mortyImage.center.x = mortyImage.center.x + view.bounds.width/2
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.portalImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            strongSelf.portalImage.alpha = 1
        }
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleImage.center.y = strongSelf.titleImage.center.y + (strongSelf.view.bounds.height/2)
        }
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.rickImage.center.x = strongSelf.rickImage.center.x + strongSelf.view.bounds.width/2
        }
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.mortyImage.center.x = strongSelf.mortyImage.center.x - strongSelf.view.bounds.width/2
        } completion: { [weak self] _ in
            self?.navigateToMainScreen()
        }
    }
    
    func navigateToMainScreen() {
        UIView.animate(withDuration: 1.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.portalImage.alpha = 0
        }
        
        UIView.animate(withDuration: 1.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.rickImage.center.x = strongSelf.rickImage.center.x - strongSelf.view.bounds.width/2
        }
        
        UIView.animate(withDuration: 1.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.mortyImage.center.x = strongSelf.mortyImage.center.x + strongSelf.view.bounds.width/2
        }
        
        UIView.animate(withDuration: 2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleImage.center.y = strongSelf.titleImage.center.y - (strongSelf.view.bounds.height/2)
        } completion: { [weak self] _ in
            self?.coordinator?.navigateToMainView()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    LaunchViewController()
}
