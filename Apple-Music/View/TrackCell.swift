//
//  TrackCell.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

protocol TrackCellDelegate {
  func cancelTapped(_ cell: TrackCell)
  func downloadTapped(_ cell: TrackCell)
  func pauseTapped(_ cell: TrackCell)
  func resumeTapped(_ cell: TrackCell)
}

class TrackCell: UITableViewCell {
  static let identifier = CellsID.trackCellId
  
  /// Delegate identifies track for this cell, then
  /// passes this to a downlaod service method.
  var delegate: TrackCellDelegate?
  
  func configure(track: Track, download: Bool) {
    /// If the track is already downloaded, enable cell selection and hide the Download button.
    selectionStyle = download ? UITableViewCell.SelectionStyle.gray :
      UITableViewCell.SelectionStyle.none
  }
}
