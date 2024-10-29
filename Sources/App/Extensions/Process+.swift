//
//  Process.swift
//  ServerMonitor
//
//  Created by Slava Anishchuk on 29.10.2024.
//
import Foundation

extension Process {
    func run(executableURL: URL, arguments: [String]? = nil) throws -> String {
        self.executableURL = executableURL
        self.arguments = arguments
        
        let pipe = Pipe()
        standardOutput = pipe
        standardError = pipe
        
        try run()
        waitUntilExit()
        
        guard terminationStatus == EXIT_SUCCESS else {
            let error = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
            return error?.description ?? ""
        }
        let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        return output?.trimmingCharacters(in: .newlines) ?? ""
    }
}
