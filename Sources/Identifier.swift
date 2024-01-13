//
//  Identifier.swift
//  Demo
//
//  Created by Andreas Verhoeven on 12/01/2024.
//

import Foundation

/// A uniquely typed identifier that is used like:
/// ```
///	struct MyStruct: SpecificIdentifiable {
///		var id = ID.unique //
///	}
///
/// struct AnotherStruct {
/// 		var id = Identifier<AnotherStruct>
/// }
///
/// ```
///  `MyStruct.id` and `AnotherStruct.id` are different types.
public struct TaggedStringIdentifier<Tag>: RawRepresentable, Hashable {
	/// The value of this identifier
	public var rawValue: String
	
	/// creates a `TaggedStringIdentifier` with a value
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
	
	/// Returns an identifier with a uuid as value
	public static var unique: Self {
		Self(rawValue: UUID().uuidString)
	}
}

extension TaggedStringIdentifier: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.rawValue = try container.decode(String.self)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

/// Confirm to this protocol to automatically have an `ID` type in your struct/class
public protocol TaggedStringIdentifiable: Identifiable {
	associatedtype ID = TaggedStringIdentifier<Self>
}
