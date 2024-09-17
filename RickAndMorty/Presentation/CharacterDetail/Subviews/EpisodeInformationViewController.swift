//
//  EpisodeInformationView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-05.
//

import Foundation
import UIKit
#if DEBUG
import SwiftUI
#endif

final class EpisodeInformationViewController: UIViewController {
    
    private let episodeData: [Episode]
    private var episodeTableViewHandler: EpisodeTableViewHandler?
    
    private lazy var subTitle: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 22, weight: .medium)
        text.textColor = .cellText
        text.text = "Episodes"
        return text
    }()
    
    private lazy var episodeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EpisodeInfoCell.self, forCellReuseIdentifier: EpisodeCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    init(episodeData: [Episode]) {
        self.episodeData = episodeData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init with a decoder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
    }
    
    func setConstraints(){
        view.addSubview(self.subTitle)
        subTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor
        )
        
        view.addSubview(self.episodeTableView)
        episodeTableView.anchor(
            top: subTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10
        )
        
        self.episodeTableViewHandler = .init(episodeData: self.episodeData)
        
        episodeTableView.dataSource = self.episodeTableViewHandler
        episodeTableView.delegate = self.episodeTableViewHandler
    }
}

fileprivate final class EpisodeTableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let episodeData: [Episode]
    
    init(episodeData: [Episode]) {
        self.episodeData = episodeData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoCell.reuseIdentifier, for: indexPath) as! EpisodeInfoCell
        let episode = self.episodeData[indexPath.row]
        cell.setData(with: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! EpisodeInfoCell
        cell.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.15, delay: 0) {
            cell.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

fileprivate final class EpisodeInfoCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: EpisodeCell.self)
    
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .cell
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.15
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var episodeTitle: UILabel = {
        let text = UILabel()
        text.text = "Placeholder"
        text.font = .systemFont(ofSize: 14, weight: .semibold)
        text.textColor = .cellText
        return text
    }()
    
    private lazy var seasonInfoContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "tv"))
        container.setText(with: "Season")
        return container
    }()
    
    private lazy var airDateInfoContainer: DetailsContainerView = {
        let container = DetailsContainerView()
        container.setIconImage(with: UIImage(systemName: "calendar"))
        container.setText(with: "Air Date")
        return container
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
    }
}

extension EpisodeInfoCell {
    private func setupView() {
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
        
        view.addSubview(episodeTitle)
        episodeTitle.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        view.addSubview(seasonInfoContainer)
        seasonInfoContainer.anchor(
            top: episodeTitle.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 6,
            paddingLeft: 10
        )
        
        view.addSubview(airDateInfoContainer)
        airDateInfoContainer.anchor(
            top: episodeTitle.bottomAnchor,
            left: seasonInfoContainer.rightAnchor,
            paddingTop: 6,
            paddingLeft: 10
        )
    }
    
    func setData(with episode: Episode) {
        
    }
}

@available(iOS 17.0, *)
#Preview {
    EpisodeInfoCell()
}
