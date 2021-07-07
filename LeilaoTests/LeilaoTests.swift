//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
  
    func testDeveReceberUmLance() {
        let leilao = Leilao(descricao: "Macbook Pro 2015")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let steve = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steve,2000.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances(){
        let leilao = Leilao(descricao: "Macbook Pro 2015")
        
        let steve = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steve,2000.0))
        
        let bill = Usuario(nome: "Bill Gates")
        leilao.propoe(lance: Lance(bill,1700.0))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        XCTAssertEqual(1700.0, leilao.lances?[1].valor)
    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro")
        
        let steve = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steve, 2000.0))
        leilao.propoe(lance: Lance(steve, 2300.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisDoQueCincoLancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro")
        
        let steve = Usuario(nome: "Steve Jobs")
        let gates = Usuario(nome: "Gates")
        
        leilao.propoe(lance: Lance(steve, 2000.0))
        leilao.propoe(lance: Lance(gates, 3000.0))
        
        leilao.propoe(lance: Lance(steve, 4000.0))
        leilao.propoe(lance: Lance(gates, 5000.0))
        
        leilao.propoe(lance: Lance(steve, 6000.0))
        leilao.propoe(lance: Lance(gates, 7000.0))
        
        leilao.propoe(lance: Lance(steve, 8000.0))
        leilao.propoe(lance: Lance(gates, 9000.0))
        
        leilao.propoe(lance: Lance(steve, 10000))
        leilao.propoe(lance: Lance(gates, 11000))
        
        //Deve ignorar
        leilao.propoe(lance: Lance(steve, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)
        
    }
    
}
