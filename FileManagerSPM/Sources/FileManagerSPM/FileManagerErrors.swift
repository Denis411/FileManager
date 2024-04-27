import Foundation

public enum FileManagerErrors: Error {
    case fileAlreadyExists
}

extension FileManagerErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileAlreadyExists:
            return "File already exists"
        }
    }
}
