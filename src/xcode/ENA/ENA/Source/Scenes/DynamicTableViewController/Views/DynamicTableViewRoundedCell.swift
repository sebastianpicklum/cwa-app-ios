// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import UIKit

class DynamicTableViewRoundedCell: UITableViewCell {

	// MARK: - View elements.

	lazy var title = UILabel(frame: .zero)
	lazy var body = UILabel(frame: .zero)
	lazy var insetView = UIView(frame: .zero)

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		self.autoresizingMask = .flexibleHeight
	}

	private func setup() {

		// MARK: - General cell setup.
		selectionStyle = .none
		backgroundColor = .preferredColor(for: .backgroundPrimary)

		// MARK: - Add inset view
		insetView.backgroundColor = .preferredColor(for: .backgroundSecondary)
		insetView.layer.cornerRadius = 16.0

		// MARK: - Title adjustment.

		title.font = .preferredFont(forTextStyle: .headline)
		title.lineBreakMode = .byWordWrapping
		title.numberOfLines = 0

		// MARK: - Body adjustment.
		body.font = .preferredFont(forTextStyle: .body)
		body.lineBreakMode = .byWordWrapping
		body.numberOfLines = 0

		UIView.translatesAutoresizingMaskIntoConstraints(for: [
			insetView, title, body
		], to: false)

		addSubview(insetView)
		insetView.addSubviews([title, body])
	}

	private func setupConstraints() {
		body.sizeToFit()
		title.sizeToFit()

		let marginGuide = contentView.layoutMarginsGuide
		contentView.addSubview(insetView)
		insetView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
		insetView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
		insetView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
		insetView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true

		title.leadingAnchor.constraint(equalTo: insetView.leadingAnchor, constant: 16).isActive = true
		title.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 16).isActive = true
		title.trailingAnchor.constraint(equalTo: insetView.trailingAnchor).isActive = true

		body.leadingAnchor.constraint(equalTo: insetView.leadingAnchor, constant: 16).isActive = true
		body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
		body.trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: -16).isActive = true
		body.bottomAnchor.constraint(equalTo: insetView.bottomAnchor, constant: -16).isActive = true
	}

	func configure(title: NSMutableAttributedString, body: NSMutableAttributedString) {
		setup()
		setupConstraints()
		self.title.attributedText = title
		self.body.attributedText = body
	}
}