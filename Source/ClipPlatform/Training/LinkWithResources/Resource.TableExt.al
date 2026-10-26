namespace ClipPlatform.Training.LinkWithResources;

using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Ledger;
using Microsoft.Projects.Resources.Resource;

tableextension 50100 Resource extends Resource
{
    fields
    {
        field(50100; "Training No."; Code[20])
        {
            Caption = 'Training No.', comment = 'ESP="Nº Formación"';
            TableRelation = Training;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Training: Record Training;
                ResouceHasEntriesErr: Label 'Cannot link a resource with a training because resource has entries',
                        Comment = 'ESP="No se puede vincular el recurso con una formación porque el recurso tiene movimientos"';
            begin
                if Rec."Training No." = xRec."Training No." then
                    exit;

                if ResourceHasEntries() then
                    Error(ResouceHasEntriesErr);

                if Rec."Training No." <> '' then begin
                    Rec.Validate(Type, Rec.Type::Training);
                    Training.Get(Rec."Training No.");
                    Rec.Validate(Name, Training.Name);
                    Rec.Validate("Unit Price", Training.Price);
                    Rec.Validate(Blocked, Training.Blocked);
                end;
            end;
        }
    }

    local procedure ResourceHasEntries(): Boolean
    var
        ResLedgerEntry: Record "Res. Ledger Entry";
    begin
        ResLedgerEntry.SetRange("Resource No.", Rec."No.");
        if ResLedgerEntry.IsEmpty() then
            exit(false)
        else
            exit(true);
    end;
}