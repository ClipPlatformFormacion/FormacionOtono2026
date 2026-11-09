namespace ClipPlatform.Training.Entries;

using Microsoft.Projects.Resources.Journal;
using Microsoft.Projects.Resources.Ledger;
using Microsoft.Sales.Document;

codeunit 50101 "TrainingResourceSubscriptions"
{
    [EventSubscriber(ObjectType::Table, Database::"Res. Journal Line", OnAfterCopyResJnlLineFromSalesLine, '', false, false)]
    local procedure "Res. Journal Line_OnAfterCopyResJnlLineFromSalesLine"(var SalesLine: Record "Sales Line"; var ResJnlLine: Record "Res. Journal Line")
    begin
        ResJnlLine."Training No." := SalesLine."Training No.";
        ResJnlLine."Training Edition" := SalesLine."Training Edition";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", OnAfterCopyFromResJnlLine, '', false, false)]
    local procedure "Res. Ledger Entry_OnAfterCopyFromResJnlLine"(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        ResLedgerEntry."Training No." := ResJournalLine."Training No.";
        ResLedgerEntry."Training Edition" := ResJournalLine."Training Edition";
    end;
}