//
//  MoneyAmount.swift
//  Demo
//
//  Created by Andreas Verhoeven on 12/01/2024.
//

import Foundation

/// Models a Money Amount with an unchangeable currency.
public struct MoneyAmount: Hashable, Codable {
	public var value: Decimal
	public let currency: CurrencyCode
	
	public init(value: Decimal, currency: CurrencyCode) {
		self.value = value
		self.currency = currency
	}
	
	public static func zero(currency: CurrencyCode) -> Self {
		Self(value: .zero, currency: currency)
	}
	
	public var isZero: Bool { value.isZero }
	public var isLessThanZero: Bool { value < 0 }
	public var isGreaterThanZero: Bool { value > 0 }
	
	public var inverted: Self { self * -1 }
	public var absolute: Self { isLessThanZero ? inverted : self }
	
	public func assertHasSameCurrency(as other: Self) {
		guard other.currency == currency else { return }
		fatalError("Tried to do an operation with two MoneyAmounts with different currencies")
	}
	
	// MARK: Operators
	public static func + (left: Self, right: Self) -> Self {
		left.assertHasSameCurrency(as: right)
		return Self(value: left.value + right.value, currency: left.currency)
	}
	
	public static func += (left: inout Self, right: Self) {
		left = left + right
	}
	
	public static func - (left: Self, right: Self) -> Self {
		left.assertHasSameCurrency(as: right)
		return Self(value: left.value - right.value, currency: left.currency)
	}
	
	public static func -= (left: inout Self, right: Self) {
		left = left - right
	}
	
	public static func / (left: Self, right: Self) -> Decimal {
		left.assertHasSameCurrency(as: right)
		return left.value / right.value
	}
	
	public static func / (left: Self, right: Decimal) -> Self {
		return Self(value: left.value / right, currency: left.currency)
	}
	
	public static func /= (left: inout Self, right: Decimal) {
		left = left / right
	}
	
	public static func * (left: Self, right: Decimal) -> Self {
		return Self(value: left.value * right, currency: left.currency)
	}
	
	public static func *= (left: inout Self, right: Decimal) {
		left = left * right
	}
	
	public static func * (left: Self, right: Int) -> Self {
		return Self(value: left.value * Decimal(right), currency: left.currency)
	}
	
	public static func *= (left: inout Self, right: Int) {
		left = left * right
	}
	
	public static func * (left: Decimal, right: Self) -> Self {
		return Self(value: left * right.value, currency: right.currency)
	}
	
	public static func * (left: Int, right: Self) -> Self {
		return Self(value: Decimal(left) * right.value, currency: right.currency)
	}
	
	public static func > (left: Self, right: Self) -> Bool {
		left.assertHasSameCurrency(as: right)
		return left.value > right.value
	}
	
	public static func < (left: Self, right: Self) -> Bool {
		left.assertHasSameCurrency(as: right)
		return left.value < right.value
	}
	
	public static func >= (left: Self, right: Self) -> Bool {
		left.assertHasSameCurrency(as: right)
		return left.value >= right.value
	}
	
	public static func <= (left: Self, right: Self) -> Bool {
		left.assertHasSameCurrency(as: right)
		return left.value <= right.value
	}
	
	// MARK: Formatting
	public var formatted: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencyCode = currency.rawValue
		formatter.currencySymbol = currency.symbol
		return formatter.string(from: value as NSDecimalNumber) ?? ""
	}
	
	public func formatted(maximumNumberOfDecimals: Int) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencyCode = currency.rawValue
		formatter.currencySymbol = currency.symbol
		formatter.maximumFractionDigits = maximumNumberOfDecimals
		return formatter.string(from: value as NSDecimalNumber) ?? ""
	}
	
	public var numberOfDecimalDigits: Int {
		return Int(max(0, -value._exponent))
	}
	
	public var formattedWithOptionalDecimalDigits: String {
		if numberOfDecimalDigits == 0 {
			return formatted(maximumNumberOfDecimals: 0)
		} else {
			return formatted
		}
	}
}

extension MoneyAmount: CustomDebugStringConvertible, CustomStringConvertible {
	public var description: String { formatted }
	public var debugDescription: String { formatted }
}

