codeunit 50106 "Resource Functions"
{
    procedure ResourceHasEntries(RecNo: Code[20]): Boolean
    var
        ResLedgerEntry: Record "Res. Ledger Entry";
    begin
        ResLedgerEntry.SetRange("Resource No.", RecNo);
        if ResLedgerEntry.IsEmpty() then
            exit(false)
        else
            exit(true);
    end;
}