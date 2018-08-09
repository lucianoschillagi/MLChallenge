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
	

	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************

	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
			
        startRequest()
			

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
	

} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension BankViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		return cell
	}
	
}


extension BankViewController: UITableViewDelegate {
	
	
	
	
	
	
}
