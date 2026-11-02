namespace ClipPlatform.Training.LinkWithResources;

using ClipPlatform.Training.MasterData;
using ClipPlatform.Training.Setup;
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
                TrainingSetup: Record "Training Setup";
                ResouceHasEntriesErr: Label 'Cannot link a resource with a training because resource has entries',
                        Comment = 'ESP="No se puede vincular el recurso con una formación porque el recurso tiene movimientos"';
            begin
                if Rec."Training No." = xRec."Training No." then
                    exit;

                if ResourceHasEntries() then
                    Error(ResouceHasEntriesErr);

                CheckTrainingLinkedToAnotherResource(Rec."No.", Rec."Training No.");

                if Rec."Training No." <> '' then begin
                    Rec.Validate(Type, Rec.Type::Training);
                    Training.Get(Rec."Training No.");
                    Rec.Validate(Name, Training.Name);
                    Rec.Validate("Unit Price", Training.Price);
                    Rec.Validate(Blocked, Training.Blocked);

                    TrainingSetup.Get();
                    TrainingSetup.TestField("Base Unit of Measure");
                    TrainingSetup.TestField("Gen. Prod. Posting Group");
                    TrainingSetup.TestField("VAT Prod. Posting Group");
                    Rec.Validate("Base Unit of Measure", TrainingSetup."Base Unit of Measure");
                    Rec.Validate("Gen. Prod. Posting Group", TrainingSetup."Gen. Prod. Posting Group");
                    Rec.Validate("VAT Prod. Posting Group", TrainingSetup."VAT Prod. Posting Group");
                end;
            end;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Training No.") { }
        addlast(Brick; "Training No.") { }
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

    local procedure CheckTrainingLinkedToAnotherResource(No: Code[20]; TrainingNo: Code[20])
    var
        Resource: Record Resource;
        TrainingLinkedToAnotherResourceErr: Label 'Training %1 is already linked to Resource %2',
                        Comment = 'ESP="La formación %1 ya está vinculada con el recurso %2"';
    begin
#pragma warning disable AA0210
        Resource.SetRange("Training No.", TrainingNo);
#pragma warning restore AA0210        
        Resource.SetFilter("No.", '<>%1', No);
        if Resource.IsEmpty() then
            exit;

        Resource.FindFirst();
        Error(TrainingLinkedToAnotherResourceErr, Rec."Training No.", Resource."No.");
    end;
}