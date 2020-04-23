//
//  DetailViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFit
        return albumImage
    }()
    
    lazy var albumNameLabel: UILabel = {
        return UILabel(stylizedBoldLabelWithSize: 15, style: .largeTitle)
    }()
    
    lazy var artistNameLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSize: 15, style: .headline)
    }()
    
    lazy var genreLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSize: 15, style: .caption1)
    }()
    
    lazy var releaseDateLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSize: 15, style: .caption1)
    }()
    
    lazy var copyrightInfoLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSize: 15, style: .caption1)
    }()
    
    lazy var linkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(linkoutButtonAction),
                         for: .touchUpInside)
        button.setTitle("Go to Album Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        // button.setTitleColor(button.tintColor, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        button.titleLabel?.stylize(alignment: .center)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        return button
    }()
    let stackView = UIStackView()
    
    var albumInfoViewModel: AlbumInfoViewModel? {
        didSet {
            albumInfoViewModel?.updateView = bindData
            bindData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElements()
        view.backgroundColor = .white
    }
    
    func addUIElements() {
        view.addSubview(albumImage)
        view.addSubview(linkoutButton)
        view.addSubview(stackView)
        setImageConstraints()
        setupStackLabelsVertically()
        setLinkoutButtonConstraints()
    }
    
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor).isActive = true
        
        albumImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 12).isActive    = true
        albumImage.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 12).isActive    = true
        albumImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    func setupStackLabelsVertically() {
        
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        
        
        stackView.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(copyrightInfoLabel)
        
        
    }
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor,
                                            constant: 5).isActive    = true
        albumNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func setLinkoutButtonConstraints() {
        linkoutButton.translatesAutoresizingMaskIntoConstraints = false
        linkoutButton.topAnchor.constraint(greaterThanOrEqualTo: copyrightInfoLabel.bottomAnchor,
                                           constant: 12).isActive = true
        linkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 20).isActive = true
        linkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -20).isActive = true
        linkoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: linkoutButton.bottomAnchor,
                                                         constant: 20).isActive = true
    }
    
    func bindData() {
        guard let albumInfoViewModel = albumInfoViewModel else {
            albumNameLabel.text = nil
            artistNameLabel.text = nil
            albumImage.image = nil
            genreLabel.text = nil
            releaseDateLabel.text = nil
            copyrightInfoLabel.text = nil
            return
        }
        albumNameLabel.text = albumInfoViewModel.albumName
        artistNameLabel.text = albumInfoViewModel.artistName
        albumInfoViewModel.getArtworkImage { data in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.albumImage.image = nil
                    return
                }
                self.albumImage.image = UIImage(data: data)
            }
        }
        genreLabel.text = albumInfoViewModel.genre
        releaseDateLabel.text = albumInfoViewModel.releaseDate
        copyrightInfoLabel.text = albumInfoViewModel.copyrightInfo
    }
    
    @objc func linkoutButtonAction() {
        guard let url = albumInfoViewModel?.linkoutUrl else {
            return
        }
        UIApplication.shared.open(url, options: [:],
                                  completionHandler: nil)
    }
    
}
