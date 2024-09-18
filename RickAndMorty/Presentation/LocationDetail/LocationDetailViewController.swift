//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class LocationDetailViewController: UIViewController, Presentable {
    var viewModel: LocationDetailViewModel?
    var coordinator: LocationDetailCoordinator?
    private var tableViewHandler: LocationDetailViewTableViewHandler?
    
    private lazy var mainView = LocationDetailView(location: viewModel?.location)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
        self.setEpisodeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.cancelAllOperations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    static func create(with viewModel: LocationDetailViewModel?) -> LocationDetailViewController {
        let viewController = LocationDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        view.backgroundColor = .systemBackground
        
        mainView.setupView()
        guard let viewModel = self.viewModel else {
            fatalError("ViewModel is not instantiated")
        }
        
        view.backgroundColor = .systemBackground
        
        mainView.setupView()
        
        self.tableViewHandler = LocationDetailViewTableViewHandler(
            items: viewModel.wrappedCharacters
        )
        
        mainView.charactersTableView.dataSource = tableViewHandler
        mainView.charactersTableView.delegate = tableViewHandler
    }
}

extension LocationDetailViewController {
    private func setEpisodeData() {
        guard let location = viewModel?.location else {
            let alert = UIAlertController(title: "Operation Error", message: "Could not find Location Information", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        self.title = location.locationName
        self.mainView.progressIndicator.startAnimating()
    }
    
    private func loadData() {
        
        self.viewModel?.onError = { error in
            DispatchQueue.main.async { [weak self] in
                self?.mainView.progressIndicator.stopAnimating()
                let errorAlert = UIAlertController(title: "Operation Error", message: error, preferredStyle: .alert)
                errorAlert.addAction(.init(title: "Ok", style: .cancel))
                self?.present(errorAlert, animated: true)
            }
        }
        
        self.viewModel?.onSuccess = {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.progressIndicator.stopAnimating()
                self?.mainView.charactersTableView.reloadData()
            }
        }
        
        viewModel?.loadCharacterData()
    }
}

fileprivate final class LocationDetailViewTableViewHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    let items: ArrayWrapper<Character>
    
    init(items: ArrayWrapper<Character>) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        let character = self.items[indexPath.row]
        cell.setData(character: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CharacterCell
        cell.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.15, delay: 0) {
            cell.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
