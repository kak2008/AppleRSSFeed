//
//  AlbumDetailViewController.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import UIKit
import SafariServices

class AlbumDetailViewController: UIViewController {
    
    var viewModel: AlbumDetailViewModel?
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView: UIView = {
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
        label.textAlignment = .center
        return label
    }()
    
    private var artistLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline, compatibleWith: UIScreen.main.traitCollection)
        label.textAlignment = .center
        return label
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.body, compatibleWith: UIScreen.main.traitCollection)
        label.textAlignment = .center
        return label
    }()
    
    private var releaseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote, compatibleWith: UIScreen.main.traitCollection)
        label.textAlignment = .center
        return label
    }()
    
    private var copyRightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote, compatibleWith: UIScreen.main.traitCollection)
        label.textAlignment = .center
        return label
    }()
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let itunesButton: UIButton = {
        let button = UIButton()
        button.setTitle("itunes", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: UIFont.TextStyle.body, compatibleWith: UIScreen.main.traitCollection)
        button.addTarget(self, action: #selector(didTapItunesButton), for: .touchUpInside)
        button.backgroundColor = UIColor.systemPurple
        
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureUI()
        setupConstraints()
    }
    
    func setupViews() {
        guard let viewModel = viewModel else { return }
        title = viewModel.title
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(copyRightLabel)
        contentView.addSubview(itunesButton)
        contentView.addSubview(albumImageView)
    }
    
    func configureUI() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artistName
        genreLabel.text = viewModel.genreLabel
        releaseLabel.text = viewModel.releaseDate
        copyRightLabel.text = viewModel.copyRight
        
        if let url = viewModel.albumUrl {
            albumImageView.load(url: url)
        }
    }
    
    @objc
    func didTapItunesButton() {
        if let viewModel = viewModel, let url = viewModel.albumWebsiteUrl {
            let albumBrowserViewController = SFSafariViewController(url: url)
            albumBrowserViewController.title = viewModel.websiteViewControllerTitle
            self.navigationController?.pushViewController(albumBrowserViewController, animated: true)
        }
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let constant20 = CGFloat(20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant20),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            nameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: constant20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constant20),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            genreLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: constant20),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            releaseLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: constant20),
            releaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            releaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            copyRightLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: constant20),
            copyRightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            copyRightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            itunesButton.topAnchor.constraint(equalTo: copyRightLabel.bottomAnchor, constant: constant20),
            itunesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            itunesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            itunesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant20)
        ])
    }
}
