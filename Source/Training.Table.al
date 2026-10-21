table 50100 Training
{
    CaptionML = ENU = 'Training', ESP = 'Formación';
    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', ESP = 'Nº';

            trigger OnValidate()
            var
                ResourcesSetup: Record "Resources Setup";
                NoSeries: Codeunit "No. Series";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    ResourcesSetup.Get();
                    NoSeries.TestManual(ResourcesSetup."Resource Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            CaptionML = ENU = 'Name', ESP = 'Nombre';
        }
        field(3; Price; Decimal)
        {
            CaptionML = ENU = 'Price', ESP = 'Precio';
            DecimalPlaces = 2 : 2;
            BlankZero = true;
        }
        field(4; Blocked; Boolean)
        {
            CaptionML = ENU = 'Blocked', ESP = 'Bloqueado';
        }
        field(5; "Language Code"; Code[10])
        {
            CaptionML = ENU = 'Language Code', ESP = 'Cód. idioma';
            TableRelation = Language;
        }
        field(6; "Duration (hours)"; Decimal)
        {
            CaptionML = ENU = 'Duration (hours)', ESP = 'Duración (horas)';
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
            CaptionML = ENU = 'No. of Sessions', ESP = 'Nº sesiones';
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
            CaptionML = ENU = 'Hours per session', ESP = 'Horas por sesión';
            // MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            Editable = false;

            trigger OnValidate()
            var
                HoursCannotBeNegativeErr: TextConst ENU = 'Hours per session (%1) cannot be negative',
                                                 ESP = 'Las horas por sesión (%1) no pueden ser negativas';
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
        }
    }

    trigger OnInsert()
    var
        Training: Record Training;
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            ResourcesSetup.Get();
            ResourcesSetup.TestField("Resource Nos.");
            "No. Series" := ResourcesSetup."Resource Nos.";
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
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldTraining, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Training := Rec;
        ResourcesSetup.Get();
        ResourcesSetup.TestField("Resource Nos.");
        if NoSeries.LookupRelatedNoSeries(ResourcesSetup."Resource Nos.", OldTraining."No. Series", Training."No. Series") then begin
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