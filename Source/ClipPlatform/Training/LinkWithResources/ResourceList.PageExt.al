namespace ClipPlatform.Training.LinkWithResources;

using Microsoft.Projects.Resources.Resource;

pageextension 50101 "Resource List" extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field("Training No."; Rec."Training No.")
            {
                ApplicationArea = All;
            }
        }
    }
}