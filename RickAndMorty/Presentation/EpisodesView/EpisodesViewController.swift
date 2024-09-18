//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation
import UIKit
import SwiftUI

final class EpisodesViewController: UIViewController, Presentable {
    var viewModel: EpisodeViewModel?
    var coordinator: EpisodesCoordinator?
    private var tableViewHandler: EpisodesViewTableViewHandler?
    
    let mainView: EpisodesView = .init()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstraints()
        bindViewModel()
        loadEpisodeData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let viewModel = self.viewModel, viewModel.wrappedEpisodes.isEmpty {
            loadEpisodeData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.cancelAllOperations()
    }
    
    static func create(with viewModel: EpisodeViewModel?) -> EpisodesViewController {
        let viewController = EpisodesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension EpisodesViewController {
    func setConstraints() {
        guard let viewModel = self.viewModel else {
            fatalError("ViewModel is not instantiated")
        }
        
        mainView.setConstraints()
        self.tableViewHandler = EpisodesViewTableViewHandler(
            items: viewModel.wrappedEpisodes,
            paginationThreshold: viewModel.paginationThreshold,
            onLoadMore: viewModel.loadMoreEpisodes
        )
        
        self.tableViewHandler?.onEpisodeSelected = self.onEpisodeSelected
        
        mainView.tableView.dataSource = tableViewHandler
        mainView.tableView.delegate = tableViewHandler
        
        mainView.searchBar.delegate = self
        mainView.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc func refreshData(_ sender: Any) {
        mainView.searchBar.text = ""
        viewModel?.fetchData()
    }
    
    func loadEpisodeData() {
        mainView.progressIndicator.startAnimating()
        viewModel?.fetchData()
    }
    
    func searchEpisodeData(text: String) {
        self.viewModel?.searchText = text
        if text.isEmpty {
            mainView.progressIndicator.stopAnimating()
        } else {
            mainView.progressIndicator.startAnimating()
        }
        viewModel?.searchData()
    }
    
    func bindViewModel() {
        viewModel?.onSuccess = {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.refreshControl.endRefreshing()
                self?.mainView.progressIndicator.stopAnimating()
                self?.mainView.tableView.reloadData()
            }
        }
        
        viewModel?.onError = { errorString in
            DispatchQueue.main.async { [weak self] in
                self?.mainView.progressIndicator.stopAnimating()
                self?.mainView.refreshControl.endRefreshing()
                let errorAlert = UIAlertController(title: "Operation Error", message: errorString, preferredStyle: .alert)
                errorAlert.addAction(.init(title: "Ok", style: .cancel))
                self?.present(errorAlert, animated: true)
            }
        }
        
        viewModel?.onRefresh = { indexPaths in
            DispatchQueue.main.async { [weak self] in
                self?.mainView.tableView.beginUpdates()
                self?.mainView.tableView.insertRows(at: indexPaths, with: .fade)
                self?.mainView.tableView.endUpdates()
            }
        }
    }
    
    func scrollToTopItem() {
        guard !(viewModel?.wrappedEpisodes.isEmpty ?? true) else {
            return
        }
        
        mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
    
    func onEpisodeSelected(episode: Episode) {
        self.coordinator?.launchDetailFlow(for: episode)
    }
}

//MARK: Search bar delegates
extension EpisodesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchEpisodeData(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK:
fileprivate final class EpisodesViewTableViewHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let items: ArrayWrapper<Episode>
    let paginationThreshold: Int
    let onLoadMore: (() -> Void)
    var onEpisodeSelected: ((_ selected: Episode) -> Void)?
    
    init(items: ArrayWrapper<Episode>, paginationThreshold: Int, onLoadMore: @escaping () -> Void) {
        self.items = items
        self.paginationThreshold = paginationThreshold
        self.onLoadMore = onLoadMore
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseIdentifier, for: indexPath) as! EpisodeCell
        let episode = self.items[indexPath.row]
        cell.setData(episode: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! EpisodeCell
        cell.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.15, delay: 0) {
            cell.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        if indexPath.row == self.items.content.count - self.paginationThreshold {
            self.onLoadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard self.items.content.count > indexPath.row else {
            return 150
        }
        let episode = self.items[indexPath.row]
        let isMultiline = episode.episodeName.count > 30
        return isMultiline ? 160 : 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row: \(indexPath.row)")
        
        guard let onEpisodeSelected = self.onEpisodeSelected else {
            return
        }
        
        let episode = self.items.content[indexPath.row]
        onEpisodeSelected(episode)
    }
}

@available(iOS 17.0, *)
#Preview {
    EpisodesViewController()
}
