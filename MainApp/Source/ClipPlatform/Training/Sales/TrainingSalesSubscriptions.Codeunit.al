namespace ClipPlatform.Training.Sales;

using Microsoft.Projects.Resources.Resource;
using Microsoft.Sales.Document;

codeunit 50100 "Training Sales Subscriptions"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignResourceValues, '', false, false)]
    local procedure OnAfterAssignResourceValues_FillTrainingNo(var SalesLine: Record "Sales Line"; Resource: Record Resource)
    begin
        SalesLine."Training No." := Resource."Training No.";
    end;
}