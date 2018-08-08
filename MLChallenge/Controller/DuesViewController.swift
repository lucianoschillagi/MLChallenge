//
//  CuotasViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/*
API
cantidad cuotas
https://api.mercadopago.com/v1/payment_methods/installments?public_key=PUBLIC_KEY
*/


import UIKit

class DuesViewController: UIViewController {

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
	// para que el usuario seleccione en cuantas cuotas quiere realizar  su pago
	@IBOutlet weak var amountOfFees: UIPickerView!
	

	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	

} // end class

