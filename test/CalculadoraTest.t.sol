// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity ^0.8.24;

import "../src/Calculadora.sol";
import "../lib/forge-std/src/Test.sol";

contract CalculadoraTest is Test {
  
  Calculadora calculadora;
  address admin_ = vm.addr(1);
  address adminRandom_ = vm.addr(2);
  //uint256 firstResultado = 0; //Ejemplo para ver cómo se inicializa un Contrato de prueba con parámetros en el constructor
  //address admin = vm.addr(1); //Impersonalización de una dirección. Muy útil para los tests

  function setUp() public {

    calculadora = new Calculadora(admin_); //new Calculadora(firstResultado, admin);

  }

  //function testPrimerResultado() public {
    //uint256 primerResultado_ = calculadora.resultado;
    //assert(condition);
  //}

  //Fuzzing testings = Pruebas en las que Foundry le envía valores a mi test para hacerlos. (Random inputs)

  
  function testFuzzingRestoNatural(uint256 dividendo_, uint256 divisor_) public {
    if (divisor_ == 0) {
        vm.expectRevert();
        calculadora.restoNatural(dividendo_, divisor_);
        console.log("Division por cero");
    } else {
        uint256 resultado = calculadora.restoNatural(dividendo_, divisor_);
        assertEq(resultado, dividendo_ % divisor_);
    }
}

  function testFuzzingRestoEntero(int256 dividendo_, int256 divisor_) public {
    vm.startPrank(admin_);
    if (divisor_ == 0) {
        vm.expectRevert();
        calculadora.restoEntero(dividendo_, divisor_);
        console.log("Division por cero");
    } else {
        int256 resultado = calculadora.restoEntero(dividendo_, divisor_);
        assertEq(resultado, dividendo_ % divisor_);
    }
    vm.stopPrank();
}

  
  function testFuzzingDivisionNatural(uint256 dividendo_, uint256 divisor_) public {
    if (divisor_ == 0) {
        vm.expectRevert();
        calculadora.divisionNatural(dividendo_, divisor_);
        console.log("Division por cero");
    } else {
        uint256 resultado_ = calculadora.divisionNatural(dividendo_, divisor_);
        assertEq(resultado_, dividendo_ / divisor_);

    }
  }

  function testFuzzingDivisionEntera(int256 dividendo_, int256 divisor_) public {
    if (divisor_ == 0) {
        vm.expectRevert();
        calculadora.divisionEntera(dividendo_, divisor_);
        console.log("DivisionByZero");
    } else {
        int256 resultado_ = calculadora.divisionEntera(dividendo_, divisor_);
        assertEq(resultado_, dividendo_ / divisor_);

    }
  }

  //Unit testings = Pruebas en las que yo le voy dando los valores a los tests. (Given inputs)
  function testSumaEntera() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    int256 sumando1_ = 30;
    int256 sumando2_ = -6;

    int256 resultado_ = calculadora.sumaEntera(sumando1_, sumando2_);
    assertEq(resultado_, sumando1_ + sumando2_);
  }

  function testMultiplicacionEntera() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    int256 multiplicando1_ = 30;
    int256 multiplicando2_ = -6;

    int256 resultado_ = calculadora.multiplicacionEntera(multiplicando1_, multiplicando2_);
    assertEq(resultado_, multiplicando1_ * multiplicando2_);
  }

  function testMultiplicacionNatural() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 multiplicando1_ = 30;
    uint256 multiplicando2_ = 6;

    uint256 resultado_ = calculadora.multiplicacionNatural(multiplicando1_, multiplicando2_);
    assertEq(resultado_, multiplicando1_ * multiplicando2_);
  }

  function testRestaEntera() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    int256 minuendo_ = 30;
    int256 sustraendo_ = -6;

    int256 resultado_ = calculadora.restaEntera(minuendo_, sustraendo_);
    assertEq(resultado_, minuendo_ - sustraendo_);
  }

  function testRestaNatural_SustraendoMayorMinuendo() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 minuendo_ = 30;
    uint256 sustraendo_ = 60;

    vm.expectRevert();
    uint256 resultado_ = calculadora.restaNatural(minuendo_, sustraendo_);
    //assertEq(resultado_, minuendo_ - sustraendo_);
  }

  function testRestaNatural() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 minuendo_ = 60;
    uint256 sustraendo_ = 40;

    
    uint256 resultado_ = calculadora.restaNatural(minuendo_, sustraendo_);
    assertEq(resultado_, minuendo_ - sustraendo_);
  }

  function testSumaNatural() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 sumando1_ = 30;
    uint256 sumando2_ = 6;

    uint256 resultado_ = calculadora.sumaNatural(sumando1_, sumando2_);
    assertEq(resultado_, sumando1_ + sumando2_);
  }

  function testSumaNaturales() public {
    uint256[] memory sumandos_ = new uint256[](3);
    sumandos_[0] = 10;
    sumandos_[1] = 30;
    sumandos_[2] = 40;

    uint256 resultado_ = calculadora.sumaNaturales(sumandos_);
    assertEq(resultado_, sumandos_[0] + sumandos_[1] + sumandos_[2]);
  }

function testSumaEnteros() public {
    int256[] memory sumandos_ = new int256[](3);
    sumandos_[0] = 100;
    sumandos_[1] = -257;
    sumandos_[2] = -300;

    int256 resultado_ = calculadora.sumaEnteros(sumandos_);
    assertEq(resultado_, sumandos_[0] + sumandos_[1] + sumandos_[2]);
  }  

function testMultiplicacionNaturales() public {
    uint256[] memory multiplicandos_ = new uint256[](3);
    multiplicandos_[0] = 10;
    multiplicandos_[1] = 30;
    multiplicandos_[2] = 40;

    uint256 resultado_ = calculadora.multiplicacionNaturales(multiplicandos_);
    assertEq(resultado_, multiplicandos_[0] * multiplicandos_[1] * multiplicandos_[2]);
  }

function testMultiplicacionEnteros() public {
    int256[] memory multiplicandos_ = new int256[](3);
    multiplicandos_[0] = 10;
    multiplicandos_[1] = 30;
    multiplicandos_[2] = -40;

    int256 resultado_ = calculadora.multiplicacionEnteros(multiplicandos_);
    assertEq(resultado_, multiplicandos_[0] * multiplicandos_[1] * multiplicandos_[2]);
  }

function testDivisionNatural() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 dividendo_ = 10;
    uint256 divisor_ = 30;

    uint256 resultado_ = calculadora.divisionNatural(dividendo_, divisor_);
    assertEq(resultado_, dividendo_ / divisor_);
  }

function testDivisionEntera() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    int256 dividendo_ = 30;
    int256 divisor_ = -6;

    int256 resultado_ = calculadora.divisionEntera(dividendo_, divisor_);
    assertEq(resultado_, dividendo_ / divisor_);
  }

function testDivisionEnteraDivisorCero() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    int256 dividendo_ = -30;
    int256 divisor_ = 0;

    vm.expectRevert();
    int256 resultado_ = calculadora.divisionEntera(dividendo_, divisor_);
    //assertEq(resultado_, dividendo_ / divisor_);
  }

  function testDivisionNaturalDivisorCero() public {
    //int256[] memory multiplicandos_ = new int256[](3);
    uint256 dividendo_ = 30;
    uint256 divisor_ = 0;

    vm.expectRevert();
    uint256 resultado_ = calculadora.divisionNatural(dividendo_, divisor_);
    //assertEq(resultado_, dividendo_ / divisor_);
  }

  function testRestoEnteroNoAdmin() public {
    vm.startPrank(adminRandom_);

    int256 dividendo_ = 30;
    int256 divisor_ = 15;

    vm.expectRevert();
    int256 resultado_ = calculadora.restoEntero(dividendo_, divisor_);

    vm.stopPrank();
  }

function testRestoEnteroAdmin() public {
    vm.startPrank(admin_);

    int256 dividendo_ = 30;
    int256 divisor_ = 15;

    //vm.expectRevert();
    int256 resultado_ = calculadora.restoEntero(dividendo_, divisor_);

    vm.stopPrank();
  }

function testRestoNatural() public {
    
    uint256 dividendo_ = 320;
    uint256 divisor_ = 14;

    //vm.expectRevert();
    uint256 resultado_ = calculadora.restoNatural(dividendo_, divisor_);
    assertEq(resultado_, dividendo_ % divisor_);

  }

}
