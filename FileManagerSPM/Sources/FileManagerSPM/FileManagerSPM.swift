// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol FileManagerSPMProtocol {
    func saveInAppDirectory(data: Data, with fileName: FileName, with fileExtension: FileExtension, shouldOverwriteFile: Bool) throws
    func save(data: Data, to: URL?) async throws
}

//UIFileSharingEnabled(Application supports iTunes file sharing) and LSSupportsOpeningDocumentsInPlace must be set to "YES" in info.plist
// to let a user see the directory of your app

public typealias FileName = String
public typealias FileExtension = String

public final class FileManagerSPM: FileManagerSPMProtocol {
    
    public init() { }
    
    public func saveInAppDirectory(
        data: Data,
        with fileName: FileName,
        with fileExtension: FileExtension,
        shouldOverwriteFile: Bool
    ) throws {
        let fileURL = FileManager.appDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        do {
            let doesFileExist = FileManager.default.fileExists(atPath: fileURL.path)
            
            if doesFileExist && !shouldOverwriteFile {
                throw FileManagerErrors.fileAlreadyExists
            }
            
            FileManager.default.createFile(atPath: fileURL.path, contents: data)
            try data.write(to: fileURL)
            
        } catch {
            throw error
        }
    }
    
    public func save(data: Data, to url: URL?) async throws {
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

extension FileManagerSPM {
    private func createAppDirectoryIfNeeded() {
        
    }
}

extension FileManager {
    static let appDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    
    static func doseFileExist(at url: URL, isDirectory: ObjCBool) -> Bool {
        FileManager.default.fileExists(atPath: url.path)
    }
}
