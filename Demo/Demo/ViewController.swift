//
//  ViewController.swift
//  Demo
//
//  Created by Andreas Verhoeven on 16/05/2021.
//

import UIKit


class ViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let moneyAmount = MoneyAmount(value: 1.14, currency: .euro).inverted
		let moneyAmount2 = MoneyAmount(value: 5, currency: .usDollar)
		print(moneyAmount)
		print(moneyAmount2.formattedWithOptionalDecimalDigits)
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
}

