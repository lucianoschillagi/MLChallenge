//
//  BancoViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit
import Alamofire

class BankViewController: UIViewController {
	
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************

	var allBanks = [Bank]()
	var jsonArray: NSArray?
	var nameArray: Array<String> = []
	var thumbailURLArray: Array<String> = []
	

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var bankLabel: UILabel!
	@IBOutlet weak var banksTableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	

	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************

	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
			
        startRequest()
				startActivityIndicator()
    }
	
	
	
	
	
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener un array de diccionarios que representan los datos de contacto de diferentes usuarios
	func startRequest(){

		MercadoPagoClient.getCardIssues { (success, banks, error) in
			debugPrint("hola")
			DispatchQueue.main.async {
				if success {
					if let banks = banks {
						self.allBanks = banks // 🔌 👏
						self.banksTableView.reloadData()
						self.stopActivityIndicator()
						
						// itera el array de [Bank] con los valores ya almacenados obtenidos
						for bank in self.allBanks {
							
							//debugPrint("😛Los objetos de las tarjetas son: \(card)")
							debugPrint("📦Los nombres de las bancos asocidados a la tarjeta elegida son: \(bank.name)")
							//debugPrint("🏄🏻‍♂️Los thumb de las tarjetas aceptadas son: \(card.thumb)")
							
						}
						debugPrint("La tarjeta elegida tiene \(banks.count) bancos asociados.")
					}
					
					// detener el indicador de actividad en red
					//self.stopActivityIndicator()
				} else {
					//self.displayAlertView(nil, error)
				}
			} // end trailing closure
		}
	}
	
	//*****************************************************************
	// MARK: - Activity Indicator
	//*****************************************************************
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		activityIndicator.stopAnimating()
	}
	
	

} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension BankViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return allBanks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let bank = allBanks[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		
		cell?.textLabel?.text = bank.name
		
		return cell!
	}
	
}


extension BankViewController: UITableViewDelegate {
	
	// task: almacenar el nombre del banco seleccionado para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let bank = allBanks[(indexPath as NSIndexPath).row]
		MercadoPagoClient.ParameterValues.IssuerId = bank.name // 🔌 👏
		debugPrint("🎾 \(MercadoPagoClient.ParameterValues.IssuerId)")
	}
	
	
} // end ext
