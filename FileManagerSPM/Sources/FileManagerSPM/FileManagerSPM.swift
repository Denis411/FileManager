import Foundation

// UIFileSharingEnabled(Application supports iTunes file sharing) and LSSupportsOpeningDocumentsInPlace must be set to "YES" in info.plist
// to let a user see the directory of your app
struct FileManagerSPM {
    func createFileURL(fileName: FileName, fileExtension: FileExtension) throws -> URL {
        let appDirectory = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )

        let fileURL = appDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)

        return fileURL
    }
}

// MARK: - FileManagerSPMProtocol

extension FileManagerSPM: FileManagerSPMProtocol {
    public func saveInAppDirectory(
        data: Data,
        fileName: FileName,
        fileExtension: FileExtension,
        shouldOverwriteFile: Bool
    ) async throws {
        guard !fileName.isEmpty else {
            throw FileManagerError.fileWithoutName
        }
        guard !fileExtension.isEmpty else {
            throw FileManagerError.fileWithoutExtension
        }
        guard fileExtension.first != "." else {
            throw FileManagerError.fileExtensionFirstCharacterIsDot
        }

        guard let fileURL = try? createFileURL(fileName: fileName, fileExtension: fileExtension) else {
            throw FileManagerError.cannotCreateURL
        }

        let doesFileExist = FileManager.default.fileExists(atPath: fileURL.path)

        if doesFileExist && !shouldOverwriteFile {
            throw FileManagerError.fileAlreadyExists
        }

        let isFileSuccessfullyCreated = FileManager.default.createFile(atPath: fileURL.path, contents: data)

        if !isFileSuccessfullyCreated {
            throw FileManagerError.cannotCreateFile
        }
    }
}
