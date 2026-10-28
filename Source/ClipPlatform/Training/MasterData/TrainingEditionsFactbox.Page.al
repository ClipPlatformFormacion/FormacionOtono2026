namespace ClipPlatform.Training.MasterData;
page 50103 "Training Editions Factbox"
{
    Caption = 'Training Editions', Comment = 'ESP="Ediciones formación"';
    PageType = ListPart;
    ApplicationArea = Training;
    UsageCategory = Lists;
    SourceTable = "Training Edition";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Training No."; Rec."Training No.") { Visible = false; }
                field(Edition; Rec.Edition) { }
                field(Type; Rec.Type) { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field("Max. students"; Rec."Max. students") { }
            }
        }
    }
}