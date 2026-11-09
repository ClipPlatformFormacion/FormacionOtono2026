namespace ClipPlatform.Training.Entries;

using Microsoft.Projects.Resources.Ledger;
pageextension 50104 "Resource Ledger Entries" extends "Resource Ledger Entries"
{
    layout
    {
        addafter("Resource No.")
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