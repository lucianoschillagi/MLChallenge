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

Una estructura preparada para recibir, mapear y almacenar (para usar cuando sea necesario) ciertas propiedades de los bancos.

Convierte el objeto JSON recibido en un array de diccionarios (Foundation)

JSON -> Foundation
*/


struct Bank {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************

	// propiedades preparadas para recibir, mapear y almacenar los valores deseados:
	
	// Banco: 🏦
	// su id
	var id: String
	// su nombre
	var name: String
	//su logo
	let thumb: String?
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir un objeto Foundation (Dictionary<String:AnyObject>) 'Bank' desde el JSON obtenido.
	
	// inicializa la struct con un diccionario como parámetro requerido
	init(dictionary: [String:AnyObject]) {
		
		// id
		// captura del Json obtenido el valor de la clave 'id' y la almancena en la propiedad 'id' del objeto 'Bank' 🔌
		id = dictionary[MercadoPagoClient.Bank_JsonObject.JsonResponseKeys.BankId] as! String
		
		// name
		// captura del Json obtenido el valor de la clave 'name' y la almancena en la propiedad 'name' del objeto 'Bank' 🔌
		name = dictionary[MercadoPagoClient.Bank_JsonObject.JsonResponseKeys.BankName] as! String
		
		// thumb
		// captura del Json obtenido el valor de la clave 'secure_thumbnail' y la almancena en la propiedad 'thumb' del objeto 'Bank' 🔌
		thumb = dictionary[MercadoPagoClient.Bank_JsonObject.JsonResponseKeys.Thumb] as! String
		
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	/**
	task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'Bank'
	
	- parameter bankObjectsResult: el Json obtenido convertido a un array de diccionarios Foundation.
	- returns: un array de objetos 'Bank' con sus propiedades ya rellenadas con los valores buscados.
	*/
	
	static func banksFromResults(_ bankObjectsResult: [[String:AnyObject]]) -> [Bank] {
		
		// un array de 'Bank' listo para ser rellenado con los valores solicitados
		var bankArray = [Bank]()
		
		// itera el array de diccionarios, cada 'Bank' es un diccionario
		for bank in bankObjectsResult {
			bankArray.append(Bank(dictionary: bank))
		}
		
		// un array de objetos 'Bank' con los valores correpondientes obtenidos y almacenados
		return bankArray
	}
	
}
