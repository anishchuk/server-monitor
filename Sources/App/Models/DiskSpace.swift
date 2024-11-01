//
//  DiskSpace.swift
//  ServerMonitor
//
//  Created by Slava Anishchuk on 01.11.2024.
//

import Vapor

/// Example: df -H
/// Filesystem        Size    Used   Avail Capacity iused ifree %iused  Mounted on
/// /dev/disk1s1      494G     11G    263G     4%    408k  2.6G    0%   /
///
struct DiskSpace: Content {
    let filesystem: String
    let size: String
    let used: String
    let available: String
    let capacity: String
    let mounted: String
    
    init(
        filesystem: String,
        size: String,
        used: String,
        available: String,
        capacity: String,
        mounted: String
    ) {
        self.filesystem = filesystem
        self.size = size
        self.used = used
        self.available = available
        self.capacity = capacity
        self.mounted = mounted
    }
    
    init?(from: String) {
        let attrs: [String] = from
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        guard attrs.count == 9 else { return nil }
        self.init(
            filesystem: attrs[0],
            size: attrs[1],
            used: attrs[2],
            available: attrs[3],
            capacity: attrs[4],
            mounted: attrs[5]
        )
    }
}
