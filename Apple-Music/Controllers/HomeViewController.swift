//
//  HomeViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit
// HomeViewController with the list of all albums
class HomeViewController: UIViewController  {
    // MARK: - Properties
    let tableView = UITableView()
    var albumViewModel = AlbumViewModel()
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = AppleITuneAPI.getAlbumURL() else { return  }
        albumViewModel.downloadAlbum(url)
        
        setUpNavigationBar()
        setUpTableView()
    }
    
    override func didReceiveMemoryWarning() {
        print("HomeViewController is overloaded boy")
    }
    // MARK: - Methods
    func setUpNavigationBar() {
        let title = UILabel()
        title.text = "Top 100 Apple Music Albums"
        title.stylizeToCenter(alignment: .center)
        title.font = UIFont.init(name: "Chalkduster", size: 20.0)
        navigationItem.titleView = title
    }
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        // self-sizing cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        // get the reusable cells
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CellsID.cellReuseIdendifier)
        // update the UI of the table view with albums data
        albumViewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
//MARK: - TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.albumInfoViewModel = albumViewModel.infoAlbumViewModel(for: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.contentView.backgroundColor = UIColor.CustomColors.Blue.DodgerBlue
        }
    }
    
    // didDeselectRowAtIndexPath - change background color
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.contentView.backgroundColor = UIColor.white
        }
    }
}
// MARK: - TableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.numberOfAlbums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.cellReuseIdendifier, for: indexPath)
            as? CustomTableViewCell else {
                fatalError("Cannot dequeue cell")
        }
        // set color for cell background
        cell.contentView.backgroundColor = cell.isSelected ? UIColor.CustomColors.Blue.DodgerBlue : UIColor.white
        // get data for each cell
        cell.albumInfoViewModel = albumViewModel.infoAlbumViewModel(for: indexPath.row)
        
        return cell
    }
}
