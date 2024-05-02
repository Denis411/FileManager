import Foundation

public enum FileManagerErrors: Error {
    case fileAlreadyExists
    case fileWithoutName
    case fileWithoutExtension
    case fileExtensionFirstCharacterIsDot
}

extension FileManagerErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileAlreadyExists:
            return "File already exists"
        case .fileWithoutName:
            return "File was not given a name"
        case .fileWithoutExtension:
            return "File must have an extensnio"
        case .fileExtensionFirstCharacterIsDot:
            return "Remove a dot at the beginning of extension"
        }
    }
}
