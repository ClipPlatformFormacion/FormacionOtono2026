namespace ClipPlatform.Interface;

codeunit 50102 "Customer Level - Blank" implements ICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(0);
    end;
}