namespace ClipPlatform.Training.Test;
using ClipPlatform.GetMin;

codeunit 50150 "Test Framework"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    begin

    end;

    [Test]
    procedure Test002()
    begin
        //Error('Un error del test');
    end;

    [Test]
    procedure GetMin001()
    var
        CodeunitGetMin: Codeunit GetMin;
        NumeroA: Integer;
        NumeroB: Integer;
        Resultado: Integer;
    begin
        // [Scenario] En una llamada a GetMin con NumeroA y NumeroB, siendo A el más pequeño, el resultado es A

        // [Given] Los números 10 y 20
        NumeroA := 10;
        NumeroB := 20;

        // [When] Se llama a GetMin
        Resultado := CodeunitGetMin.GetMin(NumeroA, NumeroB);

        // [Then] El resultado es el NumeroA
        if Resultado <> NumeroA then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure GetMin002()
    var
        CodeunitGetMin: Codeunit GetMin;
        NumeroA: Integer;
        NumeroB: Integer;
        Resultado: Integer;
    begin
        // [Scenario] En una llamada a GetMin con NumeroA y NumeroB, siendo B el más pequeño, el resultado es B

        // [Given] Los números 10 y 20
        NumeroA := 20;
        NumeroB := 10;

        // [When] Se llama a GetMin
        Resultado := CodeunitGetMin.GetMin(NumeroA, NumeroB);

        // [Then] El resultado es el NumeroA
        if Resultado <> NumeroB then
            Error('El resultado no es correcto');
    end;
}