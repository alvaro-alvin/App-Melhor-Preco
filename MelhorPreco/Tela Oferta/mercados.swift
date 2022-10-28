//
//  mercados.swift
//  MelhorPreco
//
//  Created by user on 14/10/22.
//

import Foundation


struct Mercado : Decodable {
    var imagem : String
    var nome : String
    var preco : String
    var porcentagem : String
}


let mercados = """
[
{
    "imagem": "estabelecimento_1",
    "nome": "Mercado 1",
    "preco": "10,00",
    "porcentagem": "5.7"
},
{
    "imagem": "estabelecimento_2",
    "nome": "Mercado 2",
    "preco": "10,45",
    "porcentagem": "4.9"
},
{
    "imagem": "estabelecimento_3",
    "nome": "Mercado 3",
    "preco": "11,20",
    "porcentagem": "4.7"
},
{
    "imagem": "estabelecimento_4",
    "nome": "Mercado 4",
    "preco": "11,40",
    "porcentagem": "4.2"
},
{
    "imagem": "estabelecimento_1",
    "nome": "Mercado 5",
    "preco": "11,75",
    "porcentagem": "3.8"
},
{
    "imagem": "estabelecimento_3",
    "nome": "Mercado 6",
    "preco": "13,00",
    "porcentagem": "2.1"
},
{
    "imagem": "estabelecimento_2",
    "nome": "Mercado 7",
    "preco": "14,50",
    "porcentagem": "0.3"
}
]
"""

let mercadosLista = """
[
{
    "imagem": "estabelecimento_1",
    "nome": "Mercado 1",
    "preco": "237,90",
    "porcentagem": "13.7"
},
{
    "imagem": "estabelecimento_2",
    "nome": "Mercado 2",
    "preco": "260,45",
    "porcentagem": "4.9"
},
{
    "imagem": "estabelecimento_3",
    "nome": "Mercado 3",
    "preco": "267,20",
    "porcentagem": "4.7"
},
{
    "imagem": "estabelecimento_4",
    "nome": "Mercado 4",
    "preco": "11,40",
    "porcentagem": "4.2"
},
{
    "imagem": "estabelecimento_1",
    "nome": "Mercado 5",
    "preco": "302,75",
    "porcentagem": "3.8"
},
{
    "imagem": "estabelecimento_3",
    "nome": "Mercado 6",
    "preco": "312,00",
    "porcentagem": "2.1"
},
{
    "imagem": "estabelecimento_2",
    "nome": "Mercado 7",
    "preco": "330,50",
    "porcentagem": "0.3"
}
]
"""
let mercadosData = mercados.data(using: .utf8)!
let listaMercados: [Mercado] = try! JSONDecoder().decode([Mercado].self, from: mercadosData)

let mercadosListaData = mercadosLista.data(using: .utf8)!
let listaMercadosLista: [Mercado] = try! JSONDecoder().decode([Mercado].self, from: mercadosListaData)
