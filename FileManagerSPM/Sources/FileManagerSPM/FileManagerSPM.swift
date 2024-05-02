// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol FileManagerSPMProtocol {
    /// The method saves data to a document directory
    /// - Parameter data: A piece of data to be saved.
    /// - Parameter fileName: A pure(without extension) name of the file that is supposed to be saved
    /// - Parameter fileExtension: A file extension, should not contain a dot (aka ".")
    /// - Parameter shouldOverwriteFile: Defines whether an existing file with the same name and extension can be overwritten
    func saveInAppDirectory(data: Data, fileName: FileName, fileExtension: FileExtension, shouldOverwriteFile: Bool) throws
}

//UIFileSharingEnabled(Application supports iTunes file sharing) and LSSupportsOpeningDocumentsInPlace must be set to "YES" in info.plist
// to let a user see the directory of your app

public typealias FileName = String
public typealias FileExtension = String

public final class FileManagerSPM: FileManagerSPMProtocol {
    
    public init() { }
    
    public func saveInAppDirectory(
        data: Data,
        fileName: FileName,
        fileExtension: FileExtension,
        shouldOverwriteFile: Bool
    ) throws {
        guard !fileName.isEmpty else {
            throw FileManagerErrors.fileWithoutName
        }
        
        guard !fileExtension.isEmpty else {
            throw FileManagerErrors.fileWithoutExtension
        }
        
        guard fileExtension.first != "." else {
            throw FileManagerErrors.fileExtensionFirstCharacterIsDot
        }
        
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
}
