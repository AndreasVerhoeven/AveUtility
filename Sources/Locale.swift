//
//  Locale.swift
//  Demo
//
//  Created by Andreas Verhoeven on 12/01/2024.
//

import Foundation

extension Locale {
	/// Returns the localized currency symbol for a currency code. The symbol depends on the current locale:
	/// E.g. for US locals, `USD`'s symbol is `$`, but for Canadian locals `USD` symbols is `US$`.
	func localizedCurrencySymbol(forCurrencyCode currencyCode: String) -> String? {
		guard let languageCode else { return nil }
		guard let regionCode else { return nil }
		
		// currency symbols are shared, so we want $ for the US, but US$ in Canada,
		// so force a language and country code
		let components: [String: String] = [
			NSLocale.Key.languageCode.rawValue: languageCode,
			NSLocale.Key.countryCode.rawValue: regionCode,
			NSLocale.Key.currencyCode.rawValue: currencyCode,
		]
		
		let identifier = Locale.identifier(fromComponents: components)
		return Locale(identifier: identifier).currencySymbol
	}
}
