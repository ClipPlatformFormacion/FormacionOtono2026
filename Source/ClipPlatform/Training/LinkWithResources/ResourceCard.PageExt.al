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
                ApplicationArea = All;
            }
        }
    }
}