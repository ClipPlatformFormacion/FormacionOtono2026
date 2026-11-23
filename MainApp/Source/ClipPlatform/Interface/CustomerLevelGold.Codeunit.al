namespace ClipPlatform.Interface;
codeunit 50105 "Customer Level - Gold" implements ICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(10);
    end;
}