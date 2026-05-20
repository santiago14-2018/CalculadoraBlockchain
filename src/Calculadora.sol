// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity ^0.8.24;

contract Calculadora {
    //Variables

    //Errores
    error DivisionByZero();
    error RestaNoNatural();

    //Eventos
    event SumaNatural(uint256 numero1_, uint256 numero2_, uint256 resultado);
    event SumaEntera(int256 numero1_, int256 numero2_, int256 resultado);
    event SumaNaturales(uint256[] sumandos_, uint256 resultado);
    event SumaEnteros(int256[] sumandos_, int256 resultado);

    event RestaNatural(uint256 numero1_, uint256 numero2_, uint256 resultado);
    event RestaEntera(int256 numero1_, int256 numero2_, int256 resultado);

    event MultiplicacionNatural(uint256 numero1_, uint256 numero2_, uint256 resultado);
    event MultiplicacionEntera(int256 numero1_, int256 numero2_, int256 resultado);
    event MultiplicacionNaturales(uint256[] multiplicandos_, uint256 resultado);
    event MultiplicacionEnteros(int256[] multiplicandos_, int256 resultado);

    event DivisionNatural(uint256 dividendo_, uint256 divisor_, uint256 cociente_);
    event DivisionEntera(int256 dividendo_, int256 divisor_, int256 cociente_);

    event RestoNatural(uint256 dividendo_, uint256 divisor_, uint256 resto_);
    event RestoEntero(int256 dividendo_, int256 divisor_, int256 resto_);

    //Funciones
    //Externas
    function sumaNatural(uint256 numero1_, uint256 numero2_) public returns (uint256 resultado_) {
        resultado_ = sumaNaturalInterna(numero1_, numero2_);
        emit SumaNatural(numero1_, numero2_, resultado_);
    }

    function sumaEntera(int256 numero1_, int256 numero2_) public returns (int256 resultado_) {
        resultado_ = sumaEnteraInterna(numero1_, numero2_);
        emit SumaEntera(numero1_, numero2_, resultado_);
    }

    function sumaNaturales(uint256[] memory sumandos_) public returns (uint256 resultado_) {
        resultado_ = 0;
        for (uint256 i = 0; i < sumandos_.length; i++) {
            resultado_ = sumaNaturalInterna(resultado_, sumandos_[i]);
            //resultado_ += sumandos_[i];
        }
        emit SumaNaturales(sumandos_, resultado_);
    }

    function sumaEnteros(int256[] memory sumandos_) public returns (int256 resultado_) {
        resultado_ = 0;
        for (uint256 i = 0; i < sumandos_.length; i++) {
            resultado_ = sumaEnteraInterna(resultado_, sumandos_[i]);
        }
        emit SumaEnteros(sumandos_, resultado_);
    }

    function restaNatural(uint256 numero1_, uint256 numero2_) public returns (uint256 resultado_) {
        if (numero1_ < numero2_) revert RestaNoNatural();
        resultado_ = numero1_ - numero2_;
        emit RestaNatural(numero1_, numero2_, resultado_);
    }

    function restaEntera(int256 numero1_, int256 numero2_) public returns (int256 resultado_) {
        resultado_ = numero1_ - numero2_;
        emit RestaEntera(numero1_, numero2_, resultado_);
    }

    function multiplicacionNatural(uint256 numero1_, uint256 numero2_) public returns (uint256 resultado_) {
        resultado_ = multiplicacionNaturalInterna(numero1_, numero2_);
        emit MultiplicacionNatural(numero1_, numero2_, resultado_);
    }

    function multiplicacionEntera(int256 numero1_, int256 numero2_) public returns (int256 resultado_) {
        resultado_ = multiplicacionEnteraInterna(numero1_, numero2_);
        emit MultiplicacionEntera(numero1_, numero2_, resultado_);
    }

    function multiplicacionNaturales(uint256[] memory multiplicandos_) public returns (uint256 resultado_) {
        resultado_ = 1;
        for (uint256 i = 0; i < multiplicandos_.length; i++) {
            resultado_ = multiplicacionNaturalInterna(resultado_, multiplicandos_[i]);
        }
        emit MultiplicacionNaturales(multiplicandos_, resultado_);
    }

    function multiplicacionEnteros(int256[] memory multiplicandos_) public returns (int256 resultado_) {
        resultado_ = 1; //Neutro
        for (uint256 i = 0; i < multiplicandos_.length; i++) {
            resultado_ = multiplicacionEnteraInterna(resultado_, multiplicandos_[i]);
        }
        emit MultiplicacionEnteros(multiplicandos_, resultado_);
    }

    function divisionNatural(uint256 numero1_, uint256 numero2_) public returns (uint256 resultado_) {
        if (numero2_ == 0) revert DivisionByZero();

        resultado_ = numero1_ / numero2_;
        emit DivisionNatural(numero1_, numero2_, resultado_);
    }

    function divisionEntera(int256 numero1_, int256 numero2_) public returns (int256 resultado_) {
        if (numero2_ == 0) revert DivisionByZero();

        resultado_ = numero1_ / numero2_;
        emit DivisionEntera(numero1_, numero2_, resultado_);
    }

    function restoNatural(uint256 numero1_, uint256 numero2_) public returns (uint256 resultado_) {
        if (numero2_ == 0) revert DivisionByZero();

        resultado_ = numero1_ % numero2_;
        emit RestoNatural(numero1_, numero2_, resultado_);
    }

    function restoEntero(int256 numero1_, int256 numero2_) public returns (int256 resultado_) {
        if (numero2_ == 0) revert DivisionByZero();

        resultado_ = numero1_ % numero2_;
        emit RestoEntero(numero1_, numero2_, resultado_);
    }

    //Internas
    function sumaNaturalInterna(uint256 numero1_, uint256 numero2_) internal pure returns (uint256 resultado_) {
        resultado_ = numero1_ + numero2_;
        //emit SumaNatural(numero1_, numero2_, resultado_);
    }

    function sumaEnteraInterna(int256 numero1_, int256 numero2_) internal pure returns (int256 resultado_) {
        resultado_ = numero1_ + numero2_;
        //  emit SumaEntera(numero1_, numero2_, resultado_);
    }

    function multiplicacionNaturalInterna(uint256 numero1_, uint256 numero2_)
        internal
        pure
        returns (uint256 resultado_)
    {
        resultado_ = numero1_ * numero2_;
        //emit MultiplicacionNatural(numero1_, numero2_, resultado_);
    }

    function multiplicacionEnteraInterna(int256 numero1_, int256 numero2_) internal pure returns (int256 resultado_) {
        resultado_ = numero1_ * numero2_;
        //emit MultiplicacionEntera(numero1_, numero2_, resultado_);
    }
}
