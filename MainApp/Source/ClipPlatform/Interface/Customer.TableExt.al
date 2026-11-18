namespace ClipPlatform.Interface;

using Microsoft.Sales.Customer;

tableextension 50110 Customer extends Customer
{
    fields
    {
        field(50100; "Customer Level"; Enum "Customer Level")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ICustomerLevel: Interface ICustomerLevel;
            begin
                ICustomerLevel := Rec."Customer Level";
                Rec.Validate("Level Discount", ICustomerLevel.GetDiscount());
            end;
        }
        field(50101; "Level Discount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}