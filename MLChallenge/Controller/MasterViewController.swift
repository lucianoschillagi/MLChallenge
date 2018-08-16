//
//  MasterViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit


class MasterViewController: UIViewController, UITextFieldDelegate {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	
	let cashDelegate = CashTextFieldDelegate()
	
	// el monto ingresado por el usuario, capturado a través del text field
	let amount: Double = Double()
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var amountTextField: UITextField!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		amountTextField.delegate = self.cashDelegate
	
	
	}

	override func viewWillAppear(_ animated: Bool) {
		
		displayRecommendedMessage("Esta es una...", "prueba")
	}
	
	//*****************************************************************
	// MARK: - IBActions
	//*****************************************************************
	
	// task:
	@IBAction func okButtonPressed(_ sender: UIButton) {
		// TODO: comprobar si el valor ingresado en el text field es correcto
		// si es así, navegar hacia la siguiente pantalla
	}
	
	@IBAction func textFieldEditingChanged(_ sender: UITextField) {
		
		debugPrint(sender.text)
		
	}
	
	
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		return true
	}
	
	
	
	//*****************************************************************
	// MARK: - Alert View
	//*****************************************************************
	/**
	Muestra al usuario un mensaje acerca de cual ha sido el error en el su proceso de logueo.
	
	- Parameter title: El título del error.
	- Parameter message: El mensaje acerca del error.
	
	*/
	func displayRecommendedMessage(_ title: String?, _ message: String?) {
		
		// Reset UI
		//		setUIEnabled(true)
		//		stopAnimating()
		
		// Display Error in Alert Controller
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	
	


} // end class
	
	


