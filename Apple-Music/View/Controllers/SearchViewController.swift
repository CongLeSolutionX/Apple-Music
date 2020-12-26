//
//  SearchViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit

// SearchViewController allows to search, downlaod and play Apple songs 
class SearchViewController: AppleMusicViewController {
  /// Get local file path: download task stores tune here; AV player plays it.
  let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? nil
  
  let downloadService = DownloadService()
  let queryService = QueryService()
  var searchResults: [Track] = []
  
  let tableView = UITableView()
  var searchBar = UISearchBar()
  
  lazy var tapRecognizeer: UITapGestureRecognizer =  {
    var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    return recognizer
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemIndigo
    title = "Search Music"
    
    setUpTableView()
    tableView.tableFooterView = UIView()
  }
  
  override func commonInit() {
    setTabBarImage(imageName: "magnifyingglass.circle", title: "Search")
  }
  
  func setUpTableView() {
    view.addSubview(tableView)
    tableView.pin(to: view)
    tableView.delegate = self
    tableView.dataSource = self
    // self-sizing cells
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100.0
    tableView.backgroundColor = UIColor.yellow
    tableView.separatorStyle = .none
    tableView.allowsSelection = true
    
    // get the reusable cells
    tableView.register(TrackCell.self, forCellReuseIdentifier: TrackCell.identifier)
    tableView.reloadData()
  }
}


// MARK: -  UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searched: UISearchBar) {
    dismissKeyboard()
    
    guard let searchText = searchBar.text, !searchText.isEmpty else { return }
    
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    queryService.getSearchResults(searchTerm: searchText) { [weak self] searchReuslts, error in
//      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      
      guard let results = searchReuslts else { return }
      self?.searchResults = results
      self?.tableView.reloadData()
      self?.tableView.setContentOffset(CGPoint.zero, animated: false)
      
      if !error.isEmpty {
        print("Failure in searching with error: \(error)")
      }
    }
  }
  
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizeer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizeer)
  }
  
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    /// Use default style and safely unwrap the `TrackCell`
    guard let cell: TrackCell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier, for: indexPath) as? TrackCell else {
      let cell = TrackCell(style: .default, reuseIdentifier: TrackCell.identifier)
      return cell
    }
    
    /// Delegate cell button tap events to this view controller
    cell.delegate = self
    
    let track = searchResults[indexPath.row]
    cell.configure(track: track, download: track.downloaded)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// When user tap cell, play the local file, if it's downloaded
    let track = searchResults[indexPath.row]
    
    if track.downloaded {
      playDownload(track)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 62.0
  }
}

// MARK: - TrackCellDelegate
extension SearchViewController: TrackCellDelegate {
  func cancelTapped(_ cell: TrackCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    
    let track = searchResults[indexPath.row]
    downloadService.cancelDownload(track)
    reload(indexPath.row)
  }
  
  func downloadTapped(_ cell: TrackCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    
    let track = searchResults[indexPath.row]
    downloadService.startDownload(track)
    reload(indexPath.row)
  }
  
  func pauseTapped(_ cell: TrackCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    
    let track = searchResults[indexPath.row]
    downloadService.pauseDownload(track)
    reload(indexPath.row)
  }
  
  func resumeTapped(_ cell: TrackCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    
    let track = searchResults[indexPath.row]
    downloadService.resumeDownload(track)
    reload(indexPath.row)
  }
  
  
}

// MARK: - Helper methods
extension SearchViewController {
  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  func localFilePath(for url: URL) -> URL? {
    return documentsPath?.appendingPathComponent(url.lastPathComponent)
  }
  
  func playDownload(_ track: Track) {
    let playerViewController = AVPlayerViewController()
    present(playerViewController, animated: true, completion: nil)
    
    guard let url = localFilePath(for: track.previewURL) else { return }
    let player = AVPlayer(url: url)
    playerViewController.player = player
    player.play()
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func reload(_ row: Int) {
    tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
  }
}
