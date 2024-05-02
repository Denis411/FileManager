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
        let appDirectory = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        let fileURL = appDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        do {
            let doesFileExist = FileManager.default.fileExists(atPath: fileURL.path)
            
            if doesFileExist && !shouldOverwriteFile {
                throw FileManagerErrors.fileAlreadyExists
            }
            
//            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
            FileManager.default.createFile(atPath: fileURL.path, contents: data)
//            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            
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
//    static let appDirectory = FileManager.default.url(for: .documentationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    static func doseFileExist(at url: URL, isDirectory: ObjCBool) -> Bool {
        FileManager.default.fileExists(atPath: url.path)
    }
}
