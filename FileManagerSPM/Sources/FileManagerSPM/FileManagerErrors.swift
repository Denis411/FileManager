import Foundation

public enum FileManagerError: Error {
    case fileAlreadyExists
    case fileWithoutName
    case fileWithoutExtension
    case fileExtensionFirstCharacterIsDot
    case cannotCreateFile
    case cannotCreateURL
}

extension FileManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileAlreadyExists:
            return "File already exists"
        case .fileWithoutName:
            return "File was not given a name"
        case .fileWithoutExtension:
            return "File must have an extension"
        case .fileExtensionFirstCharacterIsDot:
            return "Remove a dot at the beginning of extension"
        case .cannotCreateFile:
            return "Internal error while creating a file"
        case .cannotCreateURL:
            return "Internal error while creating a file url"
        }
    }
}
