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
    
    var viewModel: AlbumCellInformation?
    
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
        
        addSubview(imageViewContainer)
        addSubview(nameLabel)
        addSubview(artistLabel)
        
        imageViewContainer.addSubview(albumImageView)
        self.accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            albumImageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 10),
            albumImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 10),
            albumImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -10),
            albumImageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            artistLabel.leadingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 12),
            artistLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            artistLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            albumImageView.widthAnchor.constraint(equalToConstant: 80)
            //albumImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        artistLabel.text = viewModel.artist
        nameLabel.text = viewModel.name
        if let albumImage = viewModel.albumImage, let url = URL(string: albumImage) {
            albumImageView.load(url: url)
        }
    }
}

struct AlbumCellInformation {
    var name: String
    var artist: String
    var albumImage: String?
}

class AlbumTableViewCellViewModel {
    var albumInformation: AlbumCellInformation?
    
    init(albumInfo: AlbumCellInformation) {
        albumInformation = albumInfo
    }
}
