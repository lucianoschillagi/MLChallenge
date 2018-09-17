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

Una estructura preparada para recibir, mapear y almacenar (para usar cuando sea necesario) ciertas propiedades de las tarjetas de crédito.

Convierte el objeto JSON recibido en un array de diccionarios (Foundation)

JSON -> Foundation

*/

struct CreditCard {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// propiedades preparadas para recibir, mapear y almacenar los valores deseados:
	
	// Tarjeta de crédito: 💳
	// su id
	var id: String
	// su nombre
	var name: String
	//su logo
	let thumb: String?
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir un objeto Foundation (Dictionary<String:AnyObject>) 'CreditCard' desde el JSON obtenido.
	
	// inicializa la struct con un diccionario como parámetro requerido
	init(dictionary: [String:AnyObject]) {
		// id
		// captura del Json obtenido el valor de la clave 'id' y la almancena en la propiedad 'id' del objeto 'CreditCard' 🔌
		id = dictionary[MercadoPagoClient.CreditCard_JsonObject.JsonResponseKeys.CreditCardId] as! String
		
		// name
		// captura del Json obtenido el valor de la clave 'name' y la almancena en la propiedad 'name' del objeto 'CreditCard' 🔌
		name = dictionary[MercadoPagoClient.CreditCard_JsonObject.JsonResponseKeys.CreditCardName] as! String
		
		// thumb
		// captura del Json obtenido el valor de la clave 'secure_thumbnail' y la almancena en la propiedad 'thumb' del objeto 'CreditCard' 🔌
		thumb = dictionary[MercadoPagoClient.CreditCard_JsonObject.JsonResponseKeys.Thumb] as? String
	
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************

	/**
	task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'CreditCard'
	
	- parameter creditCardObjectsResult: el Json obtenido convertido a un array de diccionarios Foundation.
	- returns: un array de objetos 'CreditCard' con sus propiedades ya rellenadas con los valores buscados.
	*/
	
	static func creditCardsFromResults(_ creditCardObjectsResult: [[String:AnyObject]]) -> [CreditCard] {
		
		// un array de 'CreditCard' listo para ser rellenado con los valores solicitados
		var creditCardArray = [CreditCard]()
		
		// itera el array de diccionarios, cada 'CreditCard' es un diccionario
		for creditCard in creditCardObjectsResult {
			// rellena el array de 'creditCardArray' con diccionario 'CreditCard'
			creditCardArray.append(CreditCard(dictionary: creditCard))
		}
		
		// un array de objetos 'CreditCard' con los valores correpondientes obtenidos y almacenados
		return creditCardArray
	}
	
}
