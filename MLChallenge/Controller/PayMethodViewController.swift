//
//  TarjetaViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Segunda pantalla donde el usuario elige con qué tarjeta pagar.
*/

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
	static var creditCardChoosen: String = ""
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var creditCardsTableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var nextButton: UIButton!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setUIEnabled(false)
		// networking 🚀
		startRequest()
		// activity indicator
		startActivityIndicator()
		
		userAmountLabel.text = "$ " + MasterViewController.montoSeleccionado

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
		self.activityIndicator.stopAnimating()
	}

	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener un array de diccionarios que representan los datos de contacto de diferentes usuarios
	func startRequest(){

		MercadoPagoClient.getPayMethods { (success, creditCards, error) in // 📞
			
			debugPrint("😎\(success), \(creditCards), \(error)")
			
			DispatchQueue.main.async {
				// si la solicitud fue exitosa...
				if success {
					if let creditCards = creditCards {
						self.allCreditCards = creditCards // 🔌 👏
						self.stopActivityIndicator()
						self.creditCardsTableView.reloadData()
						// itera el array de [CreditCard] con los valores ya almacenados obtenidos
						for card in self.allCreditCards {
							debugPrint("🎲Los thumbs de las tarjetas aceptadas son: \(card)")
							debugPrint("🏄🏻‍♂️Los thumb de las tarjetas aceptadas son: \(card.thumb)")

						}
						debugPrint("Mercado Pago acepta \(creditCards.count) tarjetas de crédito.")
			
					}
					
				} else {
				
				}
			} // end trailing closure
			
		}
	}
	
	//*****************************************************************
	// MARK: - UI Enabled-Disabled
	//*****************************************************************
	
	// task: habilitar o deshabilitar la UI de acuerdo a la lógica de la aplicación
	func setUIEnabled(_ enabled: Bool) {
		nextButton.isEnabled = enabled
		if enabled {
			nextButton.alpha = 1.0
		} else {
			nextButton.alpha = 0.5
		}
	}
	
} // end class
	

//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension PayMethodViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		debugPrint("la tabla de las tarjetas de crédito tiene \(allCreditCards.count) filas.")
		return allCreditCards.count
	}

	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		cell?.textLabel?.text = creditCard.name
		cell?.imageView!.contentMode = UIView.ContentMode.scaleAspectFit


		if let thumbPath = creditCard.thumb {
			// realiza la solicitud para obtener la imágen
			let _ = MercadoPagoClient.taskForGETImage(thumbPath) { (imageData, error) in
				if let image = UIImage(data:imageData!) {

					DispatchQueue.main.async {
						cell?.imageView?.image = image
					}
				} else {
					print(error ?? "empty error")
					}
				}
				
			} // end optional binding
		
		return cell!
		
		}
	
} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension PayMethodViewController: UITableViewDelegate {
	
	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
		MercadoPagoClient.ParameterValues.PaymentMethod = creditCard.id // 🔌 👏
		PayMethodViewController.creditCardChoosen = creditCard.name // 🔌 👏
		
		setUIEnabled(true)
	}
	
} // end ext


//*****************************************************************
// MARK: - Navigation (Segue)
//*****************************************************************

extension PayMethodViewController {
	
	// task: enviar a 'BankViewController' el valor de la tarjeta seleccionada, para imprimirla luego en una etiqueta
	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
		
		// si este vc tiene un segue con el identificador "toBankVC"
		if segue.identifier == "toBankVC" {
			let bankVC = segue.destination as! BankViewController
			bankVC.creditCardSelected = PayMethodViewController.creditCardChoosen

		}
	}
}


	
	
	
	
	
	
	

