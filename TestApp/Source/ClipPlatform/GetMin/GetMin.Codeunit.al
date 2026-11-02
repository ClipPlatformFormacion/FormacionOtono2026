namespace ClipPlatform.GetMin;

codeunit 50151 GetMin
{
    procedure GetMin(P1: Integer; P2: Integer): Integer
    begin
        if P1 < P2 then
            exit(P1)
        else
            exit(P2);
    end;
}