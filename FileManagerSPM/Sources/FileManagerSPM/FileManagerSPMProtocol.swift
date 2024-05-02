import Foundation

public typealias FileName = String
public typealias FileExtension = String

public protocol FileManagerSPMProtocol {
    /// The method saves data to a document directory
    /// - Parameter data: A piece of data to be saved.
    /// - Parameter fileName: A pure(without extension) name of the file that is supposed to be saved
    /// - Parameter fileExtension: A file extension, should not contain a dot (aka ".")
    /// - Parameter shouldOverwriteFile: Defines whether an existing file with the same name and extension can be overwritten
    func saveInAppDirectory(data: Data, fileName: FileName, fileExtension: FileExtension, shouldOverwriteFile: Bool) throws
}
