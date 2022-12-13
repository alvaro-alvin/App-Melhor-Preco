//
//  oferta.swift
//  MelhorPreco
//
//  Created by user219712 on 8/31/22.
//

// possui a definição da classe Oferta e as offertas mocadas no formato .json, no futuro sera coreData

import Foundation


struct Oferta : Decodable {
    var imagem : String
    var nome : String
    var preco : String
    var estabelecimento : String
    var porcentagem : String
}


let ofertas = """
[
{
    "imagem": "arroz - branco - longo fino tipo 1 - camil - 1kg",
    "nome": "Arroz - Branco - Longo Fino Tipo 1 - Camil - 1kg",
    "preco": "5,59",
    "estabelecimento": "Pão de Açúcar",
    "porcentagem": "5.7"
},
{
    "imagem": "arroz - branco - longo fino tipo 1 - camil - 1kg",
    "nome": "Arroz - Branco - Longo Fino Tipo 1 - Camil - 1kg",
    "preco": "4,75",
    "estabelecimento": "São Luiz",
    "porcentagem": "4.9"
},
{
    "imagem": "feijão carioca - tipo 1 - kicaldo - 1kg",
    "nome": "Feijão carioca - Tipo 1 - Kicaldo - 1kg",
    "preco": "8,79",
    "estabelecimento": "Pão de Açúcar",
    "porcentagem": "4.7"
},
{
    "imagem": "feijão carioca - tipo 1 - kicaldo - 1kg",
    "nome": "Feijão carioca - Tipo 1 - Kicaldo - 1kg",
    "preco": "7,99",
    "estabelecimento": "São Luiz",
    "porcentagem": "5.7"
},
{
    "imagem": "farinha - de trigo - tradicional - dona benta - 1kg",
    "nome": "Farinha - de trigo - Tradicional - Dona Benta - 1kg",
    "preco": "7,69",
    "estabelecimento": "Pão de Açúcar",
    "porcentagem": "7.0"
},
{
    "imagem": "farinha - de trigo - tradicional - dona benta - 1kg",
    "nome": "Farinha - de trigo - Tradicional - Dona Benta - 1kg",
    "preco": "4,99",
    "estabelecimento": "São Luiz",
    "porcentagem": "6.1"
},
{
    "imagem": "leite fermentado - desnatado - yakult - 480g",
    "nome": "Leite Fermentado - Desnatado - Yakult - 480g",
    "preco": "10,69",
    "estabelecimento": "Pão de Açúcar",
    "porcentagem": "5.2"
},
{
    "imagem": "leite fermentado - desnatado - yakult - 480g",
    "nome": "Leite Fermentado - Desnatado - Yakult - 480g",
    "preco": "11,05",
    "estabelecimento": "São Luiz",
    "porcentagem": "5.9"
},
{
    "imagem": "detergente - limpol - coco - 500ml",
    "nome": "Detergente - Limpol - Coco - 500ml",
    "preco": "2,49",
    "estabelecimento": "Pão de Açúcar",
    "porcentagem": "5.0"
},
{
    "imagem": "detergente - limpol - coco - 500ml",
    "nome": "Detergente - Limpol - Coco - 500ml",
    "preco": "2,85",
    "estabelecimento": "São Luiz",
    "porcentagem": "5.8"
}
]
"""
let ofertasData = ofertas.data(using: .utf8)!
let listaOfertas: [Oferta] = try! JSONDecoder().decode([Oferta].self, from: ofertasData)
