//
//  SystemInfoController.swift
//  ServerMonitor
//
//  Created by Slava Anishchuk on 01.11.2024.
//

import Vapor

struct SystemInfoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let group = routes.grouped("api", "system")
        group.get("info", use: systemInfo)
        group.get("disks-space", use: disksSpace)
    }
    
    @Sendable
    func systemInfo(_ req: Request) async -> String {
        return await Terminal.run("uname", args: "-a")
    }
    
    @Sendable
    func disksSpace(_ req: Request) async -> [DiskSpace] {
        let disksInfo = await Terminal.run("df", args: "-H").components(separatedBy: .newlines)
        var result: [DiskSpace] = []
        for (num, info) in disksInfo.enumerated() {
            if num == 0 { continue }
            if let diskInfo = DiskSpace(from: info) {
                result.append(diskInfo)
            }
        }
        return result
    }
}
