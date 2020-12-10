//
//  AlbumsViewController.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/10/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    let tableView = UITableView()
    var viewModel: AlbumsViewModel?
        
    // MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AlbumsViewModel()
        setupView()
        setupTableView()
    }
    
    // MARK:- Helper Methods
    
    func setupView() {
        title = viewModel?.viewTitle
        view.backgroundColor = UIColor.white
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

class AlbumsViewModel {
    var viewTitle = "Albums"
}
