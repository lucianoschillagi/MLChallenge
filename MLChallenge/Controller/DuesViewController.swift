//
//  CuotasViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

class DuesViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************

	
	let amountOfFeesModel = ["1", "2", "3", "4", "5", "6"]
	

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************

	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var userCreditCardLabel: UILabel!
	@IBOutlet weak var bankLabel: UILabel!
	@IBOutlet weak var userBankLabel: UILabel!
	@IBOutlet weak var dueLabel: UILabel!
	@IBOutlet var amountOfFees: UIPickerView! // para que el usuario seleccione en cuantas cuotas quiere realizar  su pago
	
	@IBOutlet weak var labelRef: UILabel!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		
		amountOfFees.dataSource = self
		amountOfFees.delegate = self
		
		
    }
    

	

} // end class


//*****************************************************************
// MARK: - Picker View Methods
//****************************************************************

extension DuesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return amountOfFeesModel.count
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return amountOfFeesModel[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		labelRef.text = amountOfFeesModel[row]
		//userDataPay.fees = amountOfFeesModel[row]
		debugPrint("😅El usuario seleccionó \(amountOfFeesModel[row]) cuotas.")
	}
	
	
} // end ext

