page 50100 "Training List"
{
    CaptionML = ENU = 'Trainings', ESP = 'Formaciones';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Training;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field(Price; Rec.Price) { }
                field(Blocked; Rec.Blocked) { }
                field("Language Code"; Rec."Language Code") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field("No. of Sessions"; Rec."No. of Sessions") { }
                field("Hours per session"; Rec."Hours per session") { }
            }
        }
    }
}