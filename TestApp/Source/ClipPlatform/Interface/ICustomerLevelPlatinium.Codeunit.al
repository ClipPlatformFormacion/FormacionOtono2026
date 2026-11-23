
namespace ClipPlatform.Interface;

codeunit 50154 "ICustomerLevel - Platinium" implements ICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(25);
    end;
}