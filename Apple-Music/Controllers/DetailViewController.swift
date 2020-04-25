//
//  DetailViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit
import StoreKit

class DetailViewController: UIViewController {
    // MARK: - UI elements
    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.configureCornerRadius()
        // albumImage.addingRedShadow()
        
        return albumImage
    }()
    
    lazy var albumNameLabel: UILabel = {
        return UILabel(stylizedBoldLabelWithSizeCenterText: 20, style: .largeTitle)
        
    }()
    
    lazy var artistNameLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSizeCenterText: 20, style: .headline)
    }()
    
    lazy var genreLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSizeCenterText: 20, style: .body)
    }()
    
    lazy var releaseDateLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSizeCenterText: 20, style: .body)
    }()
    
    lazy var copyrightInfoLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSizeCenterText: 20, style: .body)
    }()
    
    lazy var linkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(linkoutButtonAction),
                         for: .touchUpInside)
        button.setTitle("Go to Album Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.titleLabel?.stylizeToCenter(alignment: .center)
        button.backgroundColor = .blue
        
        button.layer.cornerRadius = 10
        return button
    }()
    
    let scrollView = UIScrollView()
    
    let stackView = UIStackView()
    
    var albumInfoViewModel: AlbumInfoViewModel? {
        didSet {
            albumInfoViewModel?.updateView = bindData
            bindData()
        }
    }
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElements()
        view.backgroundColor = .green
        title = "Album Details"
    }
    // MARK: - Methods
    func addUIElements() {
        view.addSubview(scrollView)
        setScrollViewConstraints()
        setupStackView()
        view.addSubview(linkoutButton)
        setLinkoutButtonConstraints()
    }
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor,
                                               constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 20).isActive = true
       
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: 20).isActive = true
        // hide the scroll view indicator 
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
   
 
    }
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // constrain stack view to scroll view
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant:  -40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        stackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        // adding UI elements into stackview
        stackView.addArrangedSubview(albumImage)
        setImageConstraints()
        stackView.addArrangedSubview(albumNameLabel)
        setAlbumNameLabelConstraints()
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(copyrightInfoLabel)
      
    }
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor).isActive = true
        albumImage.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        albumImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }
    
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor,
                                            constant: 10).isActive    = true
    }
    
    
    func setArtistNameLabelConstraints() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setGenreLabelConstraints() {
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setReleaseDateLabelConstraints() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor,
                                              constant: 12).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: 12).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -12).isActive = true
    }
    
    func setCopyrightInfoLabelConstraints() {
        copyrightInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightInfoLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor,
                                                constant: 12).isActive = true
        copyrightInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 12).isActive = true
        copyrightInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -12).isActive = true
      //e  copyrightInfoLabel.bottomAnchor.constraint(equalTo: linkoutButton.topAnchor).isActive = true
    }
    
    func setLinkoutButtonConstraints() {
        linkoutButton.translatesAutoresizingMaskIntoConstraints = false
        linkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        linkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        linkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
    
        linkoutButton.center.x = self.view.center.x // horizontally centered
      
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
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cant open the iTunes URL")
        }
    }
    
}
