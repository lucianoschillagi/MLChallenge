//
//  BancoViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/*
API
selección banco
https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=PUBLIC_KEY
*/


import UIKit
import Alamofire

class BankViewController: UIViewController {
	
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************

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
	// los bancos asociados a la tarjeta elegida
	@IBOutlet weak var banks: UIPickerView!
	

	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************

	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadDataFromAPI()
    }
	
	
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	func downloadDataFromAPI(){
		//1.
		Alamofire.request("https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=visa") .responseJSON { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "error with response status: \(status)"
				}
			}
			
			//2.
			if let JSON = response.result.value{
				//3.
				self.jsonArray = JSON as? NSArray
				//4.
				for item in self.jsonArray! as! [NSDictionary]{
					//5.
					let name = item["name"] as? String
					let thumbailURL = item["thumbnail"] as? String
					self.nameArray.append((name)!)
					self.thumbailURLArray.append((thumbailURL)!)
				}
				//6.
				//self.tableView.reloadData()
				
				// interando los arrays con los valores recibidos
				for name in self.nameArray {
					print(name)
				}
				
				for thumb in self.thumbailURLArray {
					print(thumb)
				}
				
			}
		} // end closure
	}
	
	


} // end class
