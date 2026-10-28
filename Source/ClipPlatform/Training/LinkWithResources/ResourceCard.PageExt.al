namespace ClipPlatform.Training.LinkWithResources;

using Microsoft.Projects.Resources.Resource;

pageextension 50100 "Resource Card" extends "Resource Card"
{
    layout
    {
        moveafter(Type; Blocked)
        modify("Use Time Sheet")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("Training No."; Rec."Training No.")
            {
                ApplicationArea = Training;
            }
        }
        modify(Name)
        {
            Editable = Rec."Training No." = '';
        }
        modify(Blocked)
        {
            Editable = Rec."Training No." = '';
        }
        modify("Unit Price")
        {
            Editable = Rec."Training No." = '';
        }
        modify(Type)
        {
            Editable = Rec."Training No." = '';
        }
        modify("Personal Data")
        {
            Visible = Rec."Training No." = '';
        }
    }
}