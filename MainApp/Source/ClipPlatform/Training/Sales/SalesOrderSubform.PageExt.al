namespace ClipPlatform.Training.Sales;

using Microsoft.Sales.Document;
pageextension 50102 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Training No."; Rec."Training No.")
            {
                Editable = false;
                ApplicationArea = Training;
            }
            field("Training Edition"; Rec."Training Edition")
            {
                ApplicationArea = Training;
            }
        }
    }
}