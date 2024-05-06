import XCTest
@testable import FileManagerSPM

final class FPFileManagerTests: XCTestCase {
    private let data = "This is data for testing, it should be deleted".data(using: .utf8)!
    private let fileName = "TestFile"
    private let fileExtension = "json"

    private let fileManager = FileManagerSPM()

    override func tearDown() {
        do {
            guard let doesFileExist = try? doesFileExist(with: fileName, with: fileExtension),
                  doesFileExist == true else {
                return
            }
            try removeFile(with: fileName, with: fileExtension)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testSavingWithValidData() async {
        // give
        let shouldOverwriteFile = false
        // when
        do {
            try await fileManager.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
            // then
            let doesFileExist = try? doesFileExist(with: fileName, with: fileExtension)
            XCTAssertTrue(doesFileExist ?? false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testSavingWithInvalidExtension() async {
        // give
        let shouldOverwriteFile = false
        let invalidFileExtension = ".json"
        // when
        do {
            try await fileManager.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: invalidFileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            let doesFileExist = try? doesFileExist(with: fileName, with: fileExtension)
            XCTAssertFalse(doesFileExist ?? true)

            XCTAssertEqual(error as? FileManagerError, FileManagerError.fileExtensionFirstCharacterIsDot)
        }
    }

    func testSavingWithoutName() async {
        // give
        let shouldOverwriteFile = false
        let emptyFileName = ""
        // when
        do {
            try await fileManager.saveInAppDirectory(
                data: data,
                fileName: emptyFileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            let doesFileExist = try? doesFileExist(with: fileName, with: fileExtension)
            XCTAssertFalse(doesFileExist ?? true)

            XCTAssertEqual(error as? FileManagerError, FileManagerError.fileWithoutName)
        }
    }

    func testDoubleSavingToTheSameDirectoryWithoutOverwriting() async {
        // give
        let firstFileData = "1".data(using: .utf8)!
        let secondFileData = "2".data(using: .utf8)!
        let shouldOverwriteFile = false
        // when
        do {
            try await fileManager.saveInAppDirectory(
                data: firstFileData,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )

            // trying to write data for the second time mustn't succeed
            try await fileManager.saveInAppDirectory(
                data: secondFileData,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            if let dataURL = try? fileManager.createFileURL(fileName: fileName, fileExtension: fileExtension) {
                let fetchedData = try? Data(contentsOf: dataURL)
                XCTAssertTrue(fetchedData == firstFileData)
            } else {
                XCTFail("dataURL is nil")
            }

            XCTAssertEqual(error as? FileManagerError, FileManagerError.fileAlreadyExists)
        }
    }

    func testOverwritingFilesWithTheSameName() async {
        // give
        let firstFileData = "1".data(using: .utf8)!
        let secondFileData = "2".data(using: .utf8)!
        let shouldOverwriteFile = true
        // when
        do {
            try await fileManager.saveInAppDirectory(
                data: firstFileData,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )

            let firstDataURL = try fileManager.createFileURL(fileName: fileName, fileExtension: fileExtension)
            let firstFileFetchedData = try Data(contentsOf: firstDataURL)

            // overwrites the same file, must succeed
            try await fileManager.saveInAppDirectory(
                data: secondFileData,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )

            let secondDataURL = try fileManager.createFileURL(fileName: fileName, fileExtension: fileExtension)
            let secondFetchedData = try Data(contentsOf: secondDataURL)

            // first file should be overwritten
            XCTAssertFalse(firstFileFetchedData == secondFetchedData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

extension FPFileManagerTests {
    private func doesFileExist(with fileName: String, with fileExtension: String) throws -> Bool {
        let fileURL = try fileManager.createFileURL(fileName: fileName, fileExtension: fileExtension)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }

    private func removeFile(with fileName: String, with fileExtension: String) throws {
        let fileURL = try fileManager.createFileURL(fileName: fileName, fileExtension: fileExtension)
        try FileManager.default.removeItem(at: fileURL)
    }
}
