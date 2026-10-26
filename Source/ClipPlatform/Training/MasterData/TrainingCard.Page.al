namespace ClipPlatform.Training.MasterData;

page 50101 "Training Card"
{
    Caption = 'Training Card', Comment = 'ESP="Ficha formación"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Training;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';
                field("No."; Rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
                field(Blocked; Rec.Blocked)
                {
                    Importance = Additional;
                }
            }
            group(TrainingDetails)
            {
                Caption = 'Training Details', Comment = 'ESP="Detalles formativos"';
                field("Language Code"; Rec."Language Code")
                {
                    Importance = Additional;
                }
                field("Duration (hours)"; Rec."Duration (hours)")
                {
                    Importance = Promoted;
                }
                field("No. of Sessions"; Rec."No. of Sessions") { }
                field("Hours per session"; Rec."Hours per session") { }
            }
            part(TrainingEditions; "Training Editions Factbox")
            {
                SubPageLink = "Training No." = field("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';
                field(Price; Rec.Price) { }
            }
        }
    }
}