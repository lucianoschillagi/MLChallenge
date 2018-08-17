//
//  Installments.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 08/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/*
Abstract: Un objeto que almacena los datos recibidos por el JSON 'Installments' para luego usarlos en la construcción del ´alert view´ a mostrar como fin del proceso en la pantalla inicial.
*/

struct Installments {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// propiedades preparadas para recibir, mapear y almacenar los valores deseados:

	// contiene información acerca del pago del usuario
	// un array de diccionarios que tiene SÓLO 1 miembro
	let payerCosts: [[String:AnyObject]]?
	
	// la cantidad de cuotas
	var installments: Int = 0
	
	// un mensaje que contiene información acerca del monto según la cantidad de cuotas
	var recommendMessage: String = " "
	
	// el total a pagar con la recarga de las cuotas
	var totalAmount: Double = 0
	
	
	// un array que contiene los diversos 'installments' disponibles
	static var installmentsArray: [Int] = []

	// un array que contiene los diversos 'recommendMessage' disponibles
	static var recommendMessageArray: [String] = []
	
	// un array que contiene los diversos 'totalAmount' disponibles
	static var totalAmountArray: [Double] = []
	
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir un objeto Foundation (Dictionary<String:AnyObject>) 'Installments' desde el JSON obtenido.
	
	// inicializa la struct con un diccionario como parámetro requerido
	init(dictionary: [String:AnyObject]) {
	
		// extrae el valor al que apunta la clave "payer_costs", en este caso un array de diccionarios ('Array<[String:AnyObject]>')
		payerCosts = dictionary["payer_costs"] as! [[String:AnyObject]]

		
		// comprueba si la clave "payer_costs" contiene algún valor
		if let payerCostsDictionary = payerCosts {
		
			// si es contiene algún valor, entonces iterar el array de diccionario
			// para extraer mediante las claves los valores deseados de los 5 objetos que contiene el array
			for item in payerCostsDictionary {
				
				installments = item["installments"] as! Int
				recommendMessage = item["recommended_message"] as! String
				totalAmount = item["total_amount"] as! Double
				
				// TODO: almacenar en correspondientes arrays los valores iterados de:
				// installments, recommendMessage, totalAmount
					Installments.installmentsArray.append(installments)
					Installments.recommendMessageArray.append(recommendMessage)
					Installments.totalAmountArray.append(totalAmount)
			
			}
			
		}
		
	}
	
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	/**
	task: transformar al resultado obtenido (array de objetos JSON) en un array de objetos Foundation 'Installments'
	
	- parameter installmentsObjectResult: el Json obtenido convertido a un array de diccionarios Foundation.
	- returns: un array de objetos 'Installments' con sus propiedades ya rellenadas con los valores buscados. (ATENCIÓN: este array contiene sólo 1 elemento)
	*/
	
	static func installmentsFromResults(_ installmentsObjectResult: [[String:AnyObject]]) -> [Installments] {
		
		// un array de 'Installments' listo para ser rellenado con los valores solicitados
		var installmentsArray = [Installments]()

		// itera el array de diccionarios, cada 'Installments' es un diccionario
		for installments in installmentsObjectResult {
			installmentsArray.append(Installments(dictionary: installments))
		}

		// un array de objetos 'Installments' con los valores correpondientes obtenidos y almacenados
		return installmentsArray
		
	}
	
	
} // end struct
