//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsPresenterTests: XCTestCase {
	func test_title_isLocalized() {
		XCTAssertEqual(ImageCommentsPresenter.title, localized("IMAGE_COMMENTS_TITLE"))
	}

	func test_map_createsViewModel() {
		let now = Date()
		let calendar = Calendar.current
		let locale = Locale.current
		let comments = [
			ImageComment(id: UUID(), message: "a message", createdAt: now.adding(minutes: -5), username: "a user"),
			ImageComment(id: UUID(), message: "another message", createdAt: now.adding(days: -1), username: "another user")
		]

		let viewModel = ImageCommentsPresenter.map(comments, currentDate: now, calendar: calendar, locale: locale)

		XCTAssertEqual(viewModel.comments, [
			ImageCommentViewModel(message: "a message", createdAt: "5 minutes ago", username: "a user"),
			ImageCommentViewModel(message: "another message", createdAt: "1 day ago", username: "another user")]
		)
	}

	// MARK: - Helpers

	private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
		let table = "ImageComments"
		let bundle = Bundle(for: ImageCommentsPresenter.self)
		let value = bundle.localizedString(forKey: key, value: nil, table: table)
		if value == key {
			XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
		}
		return value
	}

	private func uniqueImageComment() -> ImageComment {
		ImageComment(id: UUID(), message: "any massage", createdAt: Date(), username: "any username")
	}
}
