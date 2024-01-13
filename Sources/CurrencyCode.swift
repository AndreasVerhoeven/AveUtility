//
//  CurrencyCode.swift
//  Demo
//
//  Created by Andreas Verhoeven on 12/01/2024.
//

import Foundation

/// Models a currency code. Doesn't validate the code.
public struct CurrencyCode: RawRepresentable, Hashable {
	/// the raw currency code, e.g. "EUR"
	public var rawValue: String
	
	/// Creates a currency code with a string
	public init(rawValue: String) {
		self.rawValue = rawValue.uppercased()
	}
	
	/// The  Euro
	public static let euro = Self(rawValue: "EUR")
	
	/// The US Dollar
	public static let usDollar = Self(rawValue: "USD")
	
	/// The british Pound
	public static let britishPound = Self(rawValue: "GBP")
	
	/// An unknown currency
	public static let unknown = Self(rawValue: "")
	
	/// All common currency codes
	public static let common: [Self] = {
		if #available(iOS 16, *) {
			return Locale.commonISOCurrencyCodes.map { Self(rawValue: $0) }
		} else {
			return Locale.isoCurrencyCodes.map { Self(rawValue: $0) }
		}
	}()
	
	/// the localized name of this currency code
	public var localizedName: String {
		Locale.current.localizedString(forCurrencyCode: rawValue) ?? rawValue
	}
	
	/// the symbol of this currency code
	public var symbol: String {
		Locale.current.localizedCurrencySymbol(forCurrencyCode: rawValue) ?? rawValue
	}
}

extension CurrencyCode: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.rawValue = try container.decode(String.self)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}
