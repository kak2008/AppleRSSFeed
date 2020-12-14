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
        viewModel?.delegate = self
        
        setupView()
        setupTableView()
        viewModel?.getAlbumsData()
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
        viewModel?.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellIdentifier, for: indexPath)
        emptyCell.backgroundColor = .clear
        emptyCell.isUserInteractionEnabled = false
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell else {
            return emptyCell
        }
        let album = viewModel?.albums?[indexPath.row]
        cell.viewModel = AlbumCellInformation(name: album?.name ?? "name",
                                              artist: album?.artistName ?? "art name",
                                              albumImage: album?.artworkUrl100 ?? nil)
        cell.configure()
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = AlbumDetailViewController()
        detailViewController.album = viewModel?.albums?[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
}

extension AlbumsViewController: AlbumsDataDelegate {
    func albumsDataRetrieved() {
        tableView.reloadData()
    }
}

protocol AlbumsDataDelegate {
    func albumsDataRetrieved()
}

class AlbumsViewModel {
    var viewTitle = "Albums"
    var delegate: AlbumsDataDelegate?
    var albums: [Albums]?

    func getAlbumsData() {
        NetworkCommunicator.shared.getAlbumsData { (albums, error) in
            guard error == nil else { return }
            self.albums = albums
            self.delegate?.albumsDataRetrieved()
        }
    }
}

class NetworkCommunicator {
    static let shared = NetworkCommunicator()
    
    func getAlbumsData(completion: @escaping (_ albums: [Albums]?, _ error: Error?) ->  Void) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/50/explicit.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            do {
                let album = try decoder.decode(AlbumsData.self, from: data)
                DispatchQueue.main.async {
                    completion(album.feed.results, nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct AlbumsData: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var title: String
    var id: String
    var country: String
    var results: [Albums]
}

struct Albums: Codable {
    var artistName: String
    var id: String
    var releaseDate: String
    var name: String
    var kind: String
    var copyright: String
    var artistId: String
    var artistUrl: String
    var artworkUrl100: String
    var url: String
    var genres: [Genre]
}

struct Genre: Codable {
    var genreId: String
    var name: String
    var url: String
}


class AlbumDetailViewController: UIViewController {
    
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
    
    var album: Albums?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Album Title"
        view.backgroundColor = UIColor.white
        
        view.addSubview(nameLabel)
        view.addSubview(artistLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseLabel)
        view.addSubview(copyRightLabel)
        view.addSubview(albumImageView)
        
        guard let album = album else { return }
        
        nameLabel.text = album.name
        artistLabel.text = album.artistName
        genreLabel.text = genreLabel(album.genres)
        releaseLabel.text = album.releaseDate
        copyRightLabel.text = album.copyright
        
        if let url = URL(string: album.artworkUrl100) {
            albumImageView.load(url: url)
        }
        
        setupConstraints()
    }
    
    func genreLabel(_ genres: [Genre]) -> String {
        var genreLabel = ""
        
        genres.forEach { (genre) in
            let divider = genreLabel.count > 0 ? " | " : ""
            genreLabel = genreLabel + divider + genre.name
        }
        return genreLabel
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            albumImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            albumImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            artistLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            artistLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            genreLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            releaseLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            releaseLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            releaseLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            copyRightLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 20),
            copyRightLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            copyRightLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
