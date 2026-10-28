namespace ClipPlatform.Training.MasterData;

using ClipPlatform.Training.Setup;
using Microsoft.Foundation.NoSeries;
using System.Globalization;

table 50100 Training
{
    Caption = 'Training', Comment = 'ESP="Formación"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            // Caption = 'No.', Comment = 'ESP="Nº",FRA="bla"';

            trigger OnValidate()
            var
                TrainingSetup: Record "Training Setup";
                NoSeries: Codeunit "No. Series";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    TrainingSetup.Get();
                    NoSeries.TestManual(TrainingSetup."Training Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
        }
        field(3; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
            DecimalPlaces = 2 : 2;
            BlankZero = true;
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked', Comment = 'ESP="Bloqueado"';
        }
        field(5; "Language Code"; Code[10])
        {
            Caption = 'Language Code', Comment = 'ESP="Cód. idioma"';
            TableRelation = Language;
        }
        field(6; "Duration (hours)"; Decimal)
        {
            Caption = 'Duration (hours)', Comment = 'ESP="Duración (horas)"';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;

            trigger OnValidate()
            begin
                CalcDurations();
            end;
        }
        field(7; "No. of Sessions"; Integer)
        {
            Caption = 'No. of Sessions', Comment = 'ESP="Nº sesiones"';
            MinValue = 0;
            InitValue = 1;
            BlankZero = true;

            trigger OnValidate()
            begin
                CalcDurations();
            end;
        }
        field(8; "Hours per session"; Decimal)
        {
            Caption = 'Hours per session', Comment = 'ESP="Horas por sesión"';
            // MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            Editable = false;

            trigger OnValidate()
            var
                HoursCannotBeNegativeErr: Label 'Hours per session (%1) cannot be negative', Comment = 'ESP="Las horas por sesión (%1) no pueden ser negativas"';
            begin
                if Rec."Hours per session" < 0 then
                    Error(HoursCannotBeNegativeErr, Rec."Hours per session");
            end;
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(SK1; Name)
        {
            Unique = true;
        }
    }

    trigger OnInsert()
    var
        Training: Record Training;
        TrainingSetup: Record "Training Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            TrainingSetup.Get();
            TrainingSetup.TestField("Training Nos.");
            "No. Series" := TrainingSetup."Training Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Training.ReadIsolation(IsolationLevel::ReadUncommitted);
            Training.SetLoadFields("No.");
            while Training.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
        end;

        // DimMgt.UpdateDefaultDim(
        //   DATABASE::Resource, "No.",
        //   "Global Dimension 1 Code", "Global Dimension 2 Code");        
    end;

    local procedure CalcDurations()
    begin
        if Rec."No. of Sessions" = 0 then
            Rec."No. of Sessions" := 1;

        Rec.Validate("Hours per session", Rec."Duration (hours)" / Rec."No. of Sessions");
    end;

    procedure AssistEdit(OldTraining: Record Training) Result: Boolean
    var
        Training: Record Training;
        TrainingSetup: Record "Training Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldTraining, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Training := Rec;
        TrainingSetup.Get();
        TrainingSetup.TestField("Training Nos.");
        if NoSeries.LookupRelatedNoSeries(TrainingSetup."Training Nos.", OldTraining."No. Series", Training."No. Series") then begin
            Training."No." := NoSeries.GetNextNo(Training."No. Series");
            Rec := Training;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Training: Record Training; xOldTraining: Record Training; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Training: Record Training; xTraining: Record Training; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Training: Record Training; var IsHandled: Boolean; var xTraining: Record Training)
    begin
    end;
}