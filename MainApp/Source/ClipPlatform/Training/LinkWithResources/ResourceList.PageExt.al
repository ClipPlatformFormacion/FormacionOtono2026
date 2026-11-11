namespace ClipPlatform.Training.LinkWithResources;

using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Resource;

pageextension 50101 "Resource List" extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field("Training No."; Rec."Training No.")
            {
                ApplicationArea = Training;
            }
            field("Training Duration"; Rec."Training Duration")
            {
                ApplicationArea = Training;
            }
            field(MiElementoEnLaPagina; LLamadaAFuncion())
            {
                ApplicationArea = Training;
            }
            field(MiOtroElemento; UnaVariable)
            {
                ApplicationArea = Training;
            }
        }
    }

    var
        UnaVariable: Decimal;

    trigger OnAfterGetRecord()
    begin
        UnaVariable := LLamadaAFuncion();
    end;

    procedure LLamadaAFuncion(): Decimal
    var
        TrainingRec: Record "Training";
    begin
        if TrainingRec.Get(Rec."Training No.") then
            exit(TrainingRec."Duration (hours)");
    end;
}