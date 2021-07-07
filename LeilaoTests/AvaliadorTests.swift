//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Guilherme Golfetto on 06/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    
    var leiloeiro: Avaliador! = Avaliador()
    
     var joao: Usuario!
     var maria: Usuario!  = Usuario(nome: "Maria")
     var jose: Usuario! = Usuario(nome: "Jose")
    
    override class func setUp() {
        //roda antes de cada testes
        super.setUp()
        joao = Usuario(nome: "Joao")
    }
    
    override class func tearDown() {
        //roda apos cada teste
        super.tearDown()
    }

    func testDeveEntenderLancesEmOrdemCrescente() {
        
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
         try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao

        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        
        let leilao = Leilao(descricao: "Playstation 5")
        leilao.propoe(lance: Lance(joao,1000.0))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }

    func testDeveEncontrarOsTresMaioresLances() {

        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5")
            .lance(joao,300.0)
            .lance(maria,400.0)
            .lance(joao,500.0)
            .lance(maria,600.0).constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600, listaLances[0].valor)
        XCTAssertEqual(500, listaLances[1].valor)
        XCTAssertEqual(400, listaLances[2].valor)
        
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "PS4").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possivel avaliar leilão sem lances") { error in
            print(error.localizedDescription)
        }
    }

}
