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
            begin
                case Rec."Customer Level" of
                    Rec."Customer Level"::" ":
                        Rec.Validate("Level Discount", 0);
                    Rec."Customer Level"::Silver:
                        Rec.Validate("Level Discount", 5);
                    Rec."Customer Level"::Gold:
                        Rec.Validate("Level Discount", 10);
                    else
                        Error('Nivel %1 desconocido', Rec."Customer Level");
                end;
            end;
        }
        field(50101; "Level Discount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}