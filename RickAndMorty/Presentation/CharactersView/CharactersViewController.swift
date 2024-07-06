//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit
import SwiftUI

final class CharactersViewController: UIViewController, Presentable {
    var viewModel: CharactersViewModel?
    var coordinator: CharactersCoordinator?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Character"
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var progressIndicator: ProgressView = ProgressView()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstraints()
        bindViewModel()
        loadCharacterData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let viewModel = self.viewModel, viewModel.characters.isEmpty {
            loadCharacterData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.cancelAllOperations()
    }
    
    static func create(with viewModel: CharactersViewModel?) -> CharactersViewController {
        let viewController = CharactersViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        view.addSubview(searchBar)
        searchBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10,
            height: 40
        )
        
        view.addSubview(tableView)
        tableView.anchor(
            top: searchBar.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        
        tableView.addSubview(refreshControl)
        
        view.addSubview(progressIndicator)
        progressIndicator.attachedView = tableView
        progressIndicator.center(inView: tableView)
    }
}

extension CharactersViewController {
    @objc func refreshData(_ sender: Any) {
        self.searchBar.text = ""
        viewModel?.fetchData()
    }
    
    func loadCharacterData() {
        progressIndicator.startAnimating()
        viewModel?.fetchData()
    }
    
    func searchCharacterData(text: String) {
        if text.isEmpty {
            progressIndicator.stopAnimating()
        } else {
            progressIndicator.startAnimating()
        }
        
        viewModel?.searchData(searchText: text)
    }
    
    func bindViewModel() {
        viewModel?.onSuccess = {
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl.endRefreshing()
                self?.progressIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.onError = { [weak self] errorString in
            self?.progressIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            let errorAlert = UIAlertController(title: "Operation Error", message: errorString, preferredStyle: .alert)
            errorAlert.addAction(.init(title: "Ok", style: .cancel))
            self?.present(errorAlert, animated: true)
        }
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        
        self.searchCharacterData(text: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text else {
            return
        }
        
        self.searchCharacterData(text: text)
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        cell.setData(character: viewModel?.characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CharacterCell
        cell.view.center.x = cell.view.center.x - cell.contentView.bounds.width / 2
                
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0) {
            cell.view.center.x = cell.view.center.x + cell.contentView.bounds.width / 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row: \(indexPath.row)")
    }
}

@available(iOS 17.0, *)
#Preview {
    CharactersViewController()
}
