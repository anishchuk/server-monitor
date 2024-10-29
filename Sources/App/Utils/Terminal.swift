//
//  Terminal.swift
//  ServerMonitor
//
//  Created by Slava Anishchuk on 29.10.2024.
//
import Foundation

final class Terminal {
    static func run(
        _ program: String,
        args: String = "",
        binPath: String = "/bin"
    ) async -> String {
        print("run: \(program) \(args)")
        let output = try? Process().run(
            executableURL: URL(fileURLWithPath: "\(binPath)/\(program)"),
            arguments: args.split(separator: " ").map { String($0) }
        )
        return output ?? "⚠️ Not executed!"
    }
}
