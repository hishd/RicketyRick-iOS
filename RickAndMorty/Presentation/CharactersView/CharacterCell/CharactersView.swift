//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-07.
//

import Foundation
import UIKit

final class CharactersView: UIView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Character"
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var progressIndicator: ProgressView = ProgressView()
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        return control
    }()
    
    func setConstraints() {
        addSubview(searchBar)
        searchBar.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10,
            height: 40
        )
        
        addSubview(tableView)
        tableView.anchor(
            top: searchBar.bottomAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        
        tableView.addSubview(refreshControl)
        
        addSubview(progressIndicator)
        progressIndicator.attachedView = tableView
        progressIndicator.center(inView: tableView)
    }
}
