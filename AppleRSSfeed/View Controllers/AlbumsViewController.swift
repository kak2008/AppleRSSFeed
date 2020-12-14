//
//  AlbumsViewController.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/10/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import UIKit
import SafariServices

class AlbumsViewController: UIViewController, AlbumsDataDelegate {
    let tableView = UITableView()
    var viewModel: AlbumsViewModel?
    
    private let emptyCellIdentifier = "emptyCell"
        
    // MARK:- View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AlbumsViewModel(delegate: self)
        
        setupView()
        setupTableView()
        viewModel?.getAlbumsData()
    }
    
    // MARK:- Helper Methods
    
    func setupView() {
        title = viewModel?.viewTitle
        view.backgroundColor = UIColor.systemBackground
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: emptyCellIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func albumsDataRetrieved() {
        tableView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        tableView.reloadData()
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellIdentifier, for: indexPath)
        emptyCell.backgroundColor = .clear
        emptyCell.isUserInteractionEnabled = false
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell,
            let cellViewModel = viewModel?.cellViewModel(for: indexPath) else {
            return emptyCell
        }
        
        cell.viewModel = cellViewModel
        cell.configure()
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = AlbumDetailViewController()
        let album = viewModel?.albums?[indexPath.row]
        detailViewController.viewModel = AlbumDetailViewModel(album: album)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
