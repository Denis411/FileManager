import Foundation

public enum FileManagerErrors: Error {
    case fileAlreadyExists
    case fileMustHaveName
}

extension FileManagerErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileAlreadyExists:
            return "File already exists"
        case .fileMustHaveName:
            return "File was not given a name"
        }
    }
}
