import Foundation

public enum FileManagerErrors: Error {
    case fileAlreadyExists
    case fileWithoutName
}

extension FileManagerErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileAlreadyExists:
            return "File already exists"
        case .fileWithoutName:
            return "File was not given a name"
        }
    }
}
