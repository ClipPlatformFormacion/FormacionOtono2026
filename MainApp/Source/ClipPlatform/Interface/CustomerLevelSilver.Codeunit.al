namespace ClipPlatform.Interface;
codeunit 50104 "Customer Level - Silver" implements ICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(5);
    end;
}