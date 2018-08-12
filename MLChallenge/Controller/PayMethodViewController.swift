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
	var creditCardChoosen: String = ""
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var creditCardsTableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	

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
		
		// networking 🚀
		startRequest()
		// activity indicator
		startActivityIndicator()
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

		MercadoPagoClient.getPayMethods { (success, creditCards, error) in
			
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

	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		
		cell?.textLabel?.text = creditCard.name
		cell?.imageView!.contentMode = UIView.ContentMode.scaleAspectFit

		
	
		if let thumbPath = creditCard.thumb {
			debugPrint("🗿\(thumbPath)")
			// realiza la solicitud para obtener la imágen
			let _ = MercadoPagoClient.taskForGETImage(thumbPath) { (imageData, error) in
				debugPrint("🎲\(imageData)")
				if let image = UIImage(data:imageData!) {
					debugPrint("😎\(image)")
					DispatchQueue.main.async {
						cell?.imageView?.image = image
					}
				} else {
					print(error ?? "empty error")
					}
				}
				
			} // end conditional binding
		
		return cell!
		
		}
	
} // end class


extension PayMethodViewController: UITableViewDelegate {
	
	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
		MercadoPagoClient.ParameterValues.PaymentMethod = creditCard.id // 🔌 👏
		debugPrint("😅 \(MercadoPagoClient.ParameterValues.PaymentMethod)")
	}
	
} // end ext

	
	
	
	
	
	
	
	
	
	
	
	

