namespace ClipPlatform.Training.Sales;

using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Ledger;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Sales.Document;

codeunit 50100 "Training Sales Subscriptions"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignResourceValues, '', false, false)]
    local procedure OnAfterAssignResourceValues_FillTrainingNo(var SalesLine: Record "Sales Line"; Resource: Record Resource)
    begin
        SalesLine."Training No." := Resource."Training No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, Quantity, false, false)]
    local procedure OnAfterValidateQuantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        CheckMaxStudentsForTrainingEdition(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Training Edition", false, false)]
    local procedure OnAfterValidateTrainingEdition(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        CheckMaxStudentsForTrainingEdition(Rec);
    end;

    local procedure CheckMaxStudentsForTrainingEdition(var SalesLine: Record "Sales Line")
    var
        TrainingEdition: Record "Training Edition";
        ResLedgerEntry: Record "Res. Ledger Entry";
        SalesQty: Decimal;
    begin
        if SalesLine.Type <> SalesLine.Type::Resource then
            exit;

        if SalesLine."Training No." = '' then
            exit;

        if (SalesLine."Training Edition" = '') or (SalesLine.Quantity = 0) then
            exit;

        TrainingEdition.SetLoadFields("Max. students");
        TrainingEdition.Get(SalesLine."Training No.", SalesLine."Training Edition");  // SELECT * FROM "Training Edition" WHERE "Training No." = SalesLine."Training No." AND "Edition" = SalesLine."Training Edition"

        ResLedgerEntry.SetRange("Training No.", SalesLine."Training No.");
        ResLedgerEntry.SetRange("Training Edition", SalesLine."Training Edition");
        ResLedgerEntry.SetLoadFields(Quantity); // SELECT Quantity FROM "Res. Ledger Entry" WHERE "Training No." = SalesLine."Training No." AND "Training Edition" = SalesLine."Training Edition"
        if ResLedgerEntry.FindSet() then
            repeat
                SalesQty := SalesQty + ResLedgerEntry.Quantity;
            until ResLedgerEntry.Next() = 0;
        SalesQty := -SalesQty;

        if SalesQty + SalesLine.Quantity > TrainingEdition."Max. students" then
            Message('Con las vetas previas (%1) y la cantidad actual (%2), se supera el máximo de estudiantes (%3).', SalesQty, SalesLine.Quantity, TrainingEdition."Max. students");
    end;
}