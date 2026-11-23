namespace ClipPlatform.Interface;
codeunit 50103 "Customer Level - Bronze" implements ICustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(2);
    end;
}