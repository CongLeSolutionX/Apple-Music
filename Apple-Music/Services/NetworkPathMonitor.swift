//
//  NetworkPathMonitor.swift
//  Apple-Music
//
//  Created by Cong Le on 12/14/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Network
var monitor = NWPathMonitor()
monitor = NWPathMonitor()
monitor.start(queue: .global()) // Deliver updates on the background queue
