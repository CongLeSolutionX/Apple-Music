//
//  DetailViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - UI element properties
    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.configureCornerRadius(cornerRadius: 20.0)
        return albumImage
    }()
    
    lazy var containerView : UIView = {
        let container = UIView()
        container.addCrimsonShadow(cornerRadius: 25.0)
        container.addSubview(albumImage)
        return container
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
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        // hide the scroll view indicator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackViewVertically : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let stackViewHorizontally = UIStackView()
    
    var albumInfoViewModel: AlbumInfoViewModel? {
        didSet {
            albumInfoViewModel?.updateView = bindData
            bindData()
        }
    }
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        // use gradient color for the background view
        let gradientView = GradientView(frame: self.view.bounds)
        self.view.insertSubview(gradientView, at: 0)
        
        title = "Album Details"
    }
    // MARK: - Methods
    func configureDetailView() {
        view.addSubview(linkoutButton)
        setLinkoutButtonConstraints()
        view.addSubview(scrollView)
        setScrollViewConstraints()
        setupStackView()
    }
    
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 20).isActive = true
        
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: linkoutButton.topAnchor).isActive = true
    }
    func setupStackView() {
        scrollView.addSubview(stackViewVertically)
        stackViewVertically.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain stack view to scroll view
        stackViewVertically.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackViewVertically.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackViewVertically.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackViewVertically.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        stackViewVertically.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        addUIElementsToStackView()
    }
    func addUIElementsToStackView() {
        // adding UI elements into stackview
        stackViewVertically.addArrangedSubview(containerView)
        setImageConstraints()
        stackViewVertically.addArrangedSubview(albumNameLabel)
        setAlbumNameLabelConstraints()
        stackViewVertically.addArrangedSubview(artistNameLabel)
        stackViewVertically.addArrangedSubview(genreLabel)
        stackViewVertically.addArrangedSubview(releaseDateLabel)
        stackViewVertically.addArrangedSubview(copyrightInfoLabel)
    }
    
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor).isActive = true
        albumImage.topAnchor.constraint(equalTo: stackViewVertically.topAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: stackViewVertically.leadingAnchor, constant: 10).isActive = true
        albumImage.trailingAnchor.constraint(equalTo: stackViewVertically.trailingAnchor, constant: -25).isActive = true
    }
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor,
                                            constant: 10).isActive    = true
    }
    
    func setLinkoutButtonConstraints() {
        linkoutButton.translatesAutoresizingMaskIntoConstraints = false
        linkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        linkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        linkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20).isActive = true
        
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
        let alertPopup = UIAlertController(title: "Open iTunes in Safari", message: "We are leaving this app and open iTunes in Safari", preferredStyle: .actionSheet)
        let confirmation = UIAlertAction(title: "I'm ok with that", style: UIAlertAction.Style.default, handler: {(action) -> Void in
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                fatalError("Cant open the iTunes link")
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        alertPopup.addAction(confirmation)
        alertPopup.addAction(cancel)
        alertPopup.fixNegativeConstraintError()
        
        present(alertPopup, animated: true, completion:  nil  )
    }
    
}
