page 50100 "Training List"
{
    CaptionML = ENU = 'Trainings', ESP = 'Formaciones';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Training;
    Editable = false;
    CardPageId = "Training Card";

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
                field("Duration (hours)"; Rec."Duration (hours)")
                {
                    Visible = false;
                }
                field("No. of Sessions"; Rec."No. of Sessions")
                {
                    Visible = false;
                }
                field("Hours per session"; Rec."Hours per session")
                {
                    Visible = false;
                }
            }
        }
        area(Factboxes)
        {
            part(TrainingEditionsFactBox; "Training Editions Factbox")
            {
                SubPageLink = "Training No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Editions)
            {
                CaptionML = ENU = 'Editions', ESP = 'Ediciones';
                RunObject = page "Training Editions";
                RunPageLink = "Training No." = field("No.");
                Image = List;
            }
        }
    }
}