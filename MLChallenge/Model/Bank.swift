//
//  Bank.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 07/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/*
Abstract: Un objeto que representa un banco.
*/

import Foundation

struct Bank {
	
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// DATOS PROVISTOS POR EL SERVIDOR (API Mercado Pago) 👈
	
	var name: String
	let thumb: String?
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir el objeto 'CreditCard' desde un diccionario (el JSON obtenido '[String:AnyObject]')
	init(dictionary: [String:AnyObject]) {
		// name
		name = dictionary["name"] as! String
		// thumb
		thumb = dictionary["thumbnail"] as! String
		
		//		// name
		//		if let nameString = dictionary["name"] as? String {
		//			name = nameString
		//		} else {
		//			name = ""
		//		}
		//
		//		// thumb
		//		if let thumbtring = dictionary["thumb"] as? String {
		//			thumb = thumbtring
		//		} else {
		//			thumb = ""
		//		}
		
		
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'Bank'
	static func banksFromResults(_ results: [[String:AnyObject]]) -> [Bank] {
		
		var banks = [Bank]()
		
		// iterate through array of dictionaries, each Movie is a dictionary
		for result in results {
			banks.append(Bank(dictionary: result))
		}
		
		return banks
	}
	
}
