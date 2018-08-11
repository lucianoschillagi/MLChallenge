//
//  CreditCard.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 07/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/*
Abstract: Un objeto que representa una tarjeta de crédito.
*/

/* Abstract:
Un objeto preparado para recibir, mapear y almacenar (para usar cuando sea necesario) propiedades de las tarjetas de crédito.
*/

import Foundation

struct CreditCard {
	
	
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
		thumb = dictionary["secure_thumbnail"] as! String
		
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
	
	// task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'CreditCard'
	static func creditCardsFromResults(_ results: [[String:AnyObject]]) -> [CreditCard] {
		
		var creditCards = [CreditCard]()
		
		// iterate through array of dictionaries, each Movie is a dictionary
		for result in results {
			creditCards.append(CreditCard(dictionary: result))
		}
		
		return creditCards
	}
	
}
