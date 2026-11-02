namespace ClipPlatform.GetMin;

codeunit 50151 GetMin
{
    procedure GetMin(P1: Integer; P2: Integer) Resultado: Integer
    begin
        Resultado := P1;
        if P2 < P1 then
            Resultado := P2;
    end;
}