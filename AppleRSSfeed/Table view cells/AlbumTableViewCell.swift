//
//  AlbumTableViewCell.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/11/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let identifier = "albumTableViewCell"
    
    var viewModel: AlbumTableViewCellViewModel?
    
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
    
    private var labelsContainer: UIView = {
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
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline, compatibleWith: UIScreen.main.traitCollection)
        return label
    }()
    
    private var artistLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline, compatibleWith: UIScreen.main.traitCollection)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        accessoryType = .disclosureIndicator
        addSubview(imageViewContainer)
        addSubview(labelsContainer)
        
        labelsContainer.addSubview(nameLabel)
        labelsContainer.addSubview(artistLabel)
        
        imageViewContainer.addSubview(albumImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageViewContainer.trailingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 20),
            imageViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            labelsContainer.topAnchor.constraint(equalTo: self.topAnchor),
            labelsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            albumImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            albumImageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -20),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            artistLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 12),
            artistLabel.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: -8),
            artistLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -20),
            
            albumImageView.widthAnchor.constraint(equalToConstant: 60),
            albumImageView.heightAnchor.constraint(equalToConstant: 60),
            
            imageViewContainer.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        artistLabel.text = viewModel.artist
        nameLabel.text = viewModel.name
        if let albumImageURL = viewModel.albumImageUrl {
            albumImageView.load(url: albumImageURL)
        }
    }
}
