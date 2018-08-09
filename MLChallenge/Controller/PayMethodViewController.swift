//
//  TarjetaViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

class PayMethodViewController: UIViewController {

	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	var jsonArray: NSArray?
	var nameArray: Array<String> = []
	var thumbailURLArray: Array<String> = []
	
	// las tarjetas de crédito aceptadas por Mercado Pago
	var allCreditCards = [CreditCard]()
	// la tarjeta de crédito seleccionada por el usuario
	static let creditCardChoosen: String = ""
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var creditCardsTableView: UITableView!
	

	//*****************************************************************
	// MARK: - IBActions
	//*****************************************************************
	@IBAction func okButtonPressed(_ sender: UIButton) {
		// cuando este botón es presionado, la aplicación navega hacia la siguiente página
		
	}
	
	
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	override func viewDidLoad() {
        super.viewDidLoad()
		
		startRequest()

//		// 1. realiza la llamada a la API de Mercado Libre para obtener los medios de pago permitidos 🚀
//		Alamofire.request("https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88").responseJSON { response in
//
//			// response status code
//			if let status = response.response?.statusCode {
//				switch(status){
//				case 200:
//					print("example success")
//				default:
//					let errorMessage = "error with response status: \(status)"
//					//completionHandlerForContactObject(false, nil, errorMessage)
//				}
//			}
//			// 2.  almacena la respuesta del servidor temporalmente en la constante 'jsonObjectResult' 📦
//			if let jsonObjectResult = response.result.value {
//
//				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
//				//let resultsContacts = Contact.contactsFromResults(jsonObjectResult as! [[String : AnyObject]])
//				debugPrint("el json obtenido es: \(jsonObjectResult)")
//				// le pasa al completion handler el objeto recibido 'resultContacts' y que la solcitud fue exitosa
//				//completionHandlerForContactObject(true, resultsContacts, nil)
//
//			}
		
		}
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener un array de diccionarios que representan los datos de contacto de diferentes usuarios
	func startRequest(){

		MercadoPagoClient.getPayMethods { (success, creditCards, error) in

			DispatchQueue.main.async {
				if success {
					if let creditCards = creditCards {
						self.allCreditCards = creditCards // 🔌 👏
						
						// itera el array de [CreditCard] con los valores ya almacenados obtenidos
						for card in self.allCreditCards {
	
							//debugPrint("😛Los objetos de las tarjetas son: \(card)")
							debugPrint("📦Los nombres de las tarjetas aceptadas son: \(card.name)")
							//debugPrint("🏄🏻‍♂️Los thumb de las tarjetas aceptadas son: \(card.thumb)")

						}
						debugPrint("Mercado Pago acepta \(creditCards.count) tarjetas de crédito.")
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

extension PayMethodViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		debugPrint("la tabla de las tarjetas de crédito tiene \(allCreditCards.count) filas.")
		return allCreditCards.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		return cell
	}
	
}


extension PayMethodViewController: UITableViewDelegate {
	
	
	
	
	
	
}

	
	
	
	
	
	
	
	
	
	
	
	

