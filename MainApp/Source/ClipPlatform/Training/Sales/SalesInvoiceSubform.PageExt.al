namespace ClipPlatform.Training.Sales;

using Microsoft.Sales.Document;
pageextension 50103 "Sales Invoice Subform" extends "Sales Invoice Subform"
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