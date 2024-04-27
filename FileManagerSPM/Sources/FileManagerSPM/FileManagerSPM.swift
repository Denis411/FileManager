// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol FileManagerSPMProtocol {
    func save(data: Data, to: URL?) async throws
}

final class FileManagerSPM: FileManagerSPMProtocol {
    func saveInAppDirectory(data: Data, withFileName: String, withFileExtension: String) {
        let appDirectoryURL = NSFileManager.default.urls(for: ., in: <#T##FileManager.SearchPathDomainMask#>)
    }
    
    func save(data: Data, to url: URL?) async throws {
        guard let url else {
            throw URLError(.badURL)
        }
        
        do {
            try data.write(to: url)
        } catch {
            throw error
        }
    }
}
