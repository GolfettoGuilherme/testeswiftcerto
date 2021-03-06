//
//  Avaliador.swift
//  Leilao
//
//  Created by Alura Laranja on 04/05/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

enum ErroAvaliador: Error {
    case LeilaoSemLance(String)
}

class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude //menor numero possivel
    private var menorDeTodos = Double.greatestFiniteMagnitude //maior numero possivel
    private var maiores: [Lance] = []
    
    func avalia(leilao: Leilao) throws {
        
        if leilao.lances?.count == 0 {
            throw ErroAvaliador.LeilaoSemLance("não é possivel avaliar um leilao sem lances")
        }
        
        guard let lances = leilao.lances else { return }
        
        for lance in lances{
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
        }
        pegaOsMaioresLancesNoLeilao(leilao)
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }
    
    func tresMaiores() -> [Lance] {
        return maiores
    }
    
    private func pegaOsMaioresLancesNoLeilao(_ leilao: Leilao) {
        guard let lances = leilao.lances else { return }
        
        maiores = lances.sorted(by: { lista1, lista2 in
            return lista1.valor > lista2.valor
        })
        
        let maioreslances = maiores.prefix(3)
        
        maiores = Array(maioreslances)
    }
}
