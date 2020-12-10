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
    
    private let emptyCellIdentifier = "emptyCell"
        
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        tableView.reloadData()
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellIdentifier, for: indexPath)
        emptyCell.backgroundColor = .clear
        emptyCell.isUserInteractionEnabled = false
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell else {
            return emptyCell
        }
        cell.configure()
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
}

class AlbumsViewModel {
    var viewTitle = "Albums"
}

class AlbumTableViewCell: UITableViewCell {
    static let identifier = "albumTableViewCell"
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private var imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var artistLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageViewContainer)
        addSubview(nameLabel)
        addSubview(artistLabel)
        
        imageViewContainer.addSubview(albumImageView)
        self.accessoryType = .disclosureIndicator
        
        albumImageView.backgroundColor = UIColor.red
        
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            albumImageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 10),
            albumImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 10),
            albumImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -10),
            albumImageView.bottomAnchor.constraint(greaterThanOrEqualTo: imageViewContainer.bottomAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            artistLabel.leadingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 12),
            artistLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            artistLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            albumImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        artistLabel.text = "Hello"
        nameLabel.text = "Name"
    }
    
}
