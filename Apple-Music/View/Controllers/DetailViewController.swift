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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Album Details"
    setupViews()
    setupConstraints()
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
      // bring image to the front end
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
}

// MARK: - Setup views and constraints
extension DetailViewController {
  
  func setupViews() {
    setupGradientlayer()
    
    view.addSubview(linkoutButton)
    view.addSubview(scrollView)
    
    scrollView.addSubview(stackViewVertically)
    
    // adding UI elements into stackview
    stackViewVertically.addArrangedSubview(containerView)
    stackViewVertically.addArrangedSubview(albumNameLabel)
    stackViewVertically.addArrangedSubview(artistNameLabel)
    stackViewVertically.addArrangedSubview(genreLabel)
    stackViewVertically.addArrangedSubview(releaseDateLabel)
    stackViewVertically.addArrangedSubview(copyrightInfoLabel)
  }
  
  func setupGradientlayer() {
    // use gradient color for the background view
    let gradientView = GradientView(frame: self.view.bounds)
    self.view.insertSubview(gradientView, at: 0)
  }
  
  func setupConstraints() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    stackViewVertically.translatesAutoresizingMaskIntoConstraints = false
    albumImage.translatesAutoresizingMaskIntoConstraints = false
    albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
    linkoutButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // set ScrollView Constraints
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      scrollView.bottomAnchor.constraint(equalTo: linkoutButton.topAnchor),
      
      // constrain stack view to scroll view
      stackViewVertically.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackViewVertically.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackViewVertically.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackViewVertically.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackViewVertically.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      // Set Image Constraints
      albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor),
      albumImage.topAnchor.constraint(equalTo: stackViewVertically.topAnchor),
      albumImage.leadingAnchor.constraint(equalTo: stackViewVertically.leadingAnchor, constant: 10),
      albumImage.trailingAnchor.constraint(equalTo: stackViewVertically.trailingAnchor, constant: -25),
      
      // set constraints for Album Name Label
      albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 10),
      
      // Set constrainst for link out button
      linkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      linkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      linkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
    ])
  }
}

// MARK: - Button to link out Safari
extension DetailViewController {
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
    
    present(alertPopup, animated: true, completion:  nil)
  }
}
