namespace ClipPlatform.Training.MasterData;

using ClipPlatform.Training.ImportExport;
using ClipPlatform.Training.MasterData.Process;
using Microsoft.Sales.Customer;

page 50100 "Training List"
{
    Caption = 'Trainings', Comment = 'ESP="Formaciones"';
    PageType = List;
    ApplicationArea = Training;
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
                field("Editions (Qty.)"; Rec."Editions (Qty.)") { }
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
        area(Promoted)
        {
            actionref(EditionsPromoted; Editions) { }
            actionref(UpdateTrainingPricePromoted; UpdateTrainingPriceReport) { }
            actionref(UpdatePricePromoted; UpdateTrainingPrice) { }
            actionref(ImportDataPromoted; ImportData) { }
        }
        area(Processing)
        {
            action(Editions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                RunObject = page "Training Editions";
                RunPageLink = "Training No." = field("No.");
                Image = List;
            }
            action(UpdateTrainingPriceReport)
            {
                CaptionML = ENU = 'Update Training Price', ESP = 'Actualizar precio de formaciones';
                RunObject = report "Update Training Price";
                Image = Edit;
            }
            action(UpdateTrainingPrice)
            {
                CaptionML = ENU = 'Update Price', ESP = 'Actualizar precio ';
                Image = Edit;

                trigger OnAction()
                begin
                    Rec.Validate(Price, Rec.Price * (1 + 10 / 100));
                    Rec.Modify(true);
                end;
            }
            action(ImportData)
            {
                // RunObject = xmlport "Training Text";
                image = Info;

                trigger OnAction()
                begin
                    XmlPort.Run(Xmlport::"Training Text");
                    CurrPage.Update();
                end;
            }
        }
    }
}