namespace ClipPlatform.Training.Permissions;

using ClipPlatform.DemoApplicationArea;
using ClipPlatform.Interface;
using ClipPlatform.Training.Entries;
using ClipPlatform.Training.ImportExport;
using ClipPlatform.Training.Information;
using ClipPlatform.Training.MasterData;
using ClipPlatform.Training.MasterData.Process;
using ClipPlatform.Training.Sales;
using ClipPlatform.Training.Setup;

permissionset 50100 "Super Training"
{
    Caption = 'SUPER Training', Comment = 'ESP="SUPER Formaciones"';
    Assignable = true;
    Permissions = tabledata Training = RIMD,
        table Training = X,
        tabledata "Training Edition" = RIMD,
        page "Training List" = X,
        table "Training Edition" = X,
        page "Training Card" = X,
        page "Training Editions" = X,
        page "Training Editions Factbox" = X,
        tabledata "Training Setup" = RIMD,
        table "Training Setup" = X,
        page "Training Setup" = X,
        codeunit "Customer Level - Blank" = X,
        codeunit "Customer Level - Bronze" = X,
        codeunit "Customer Level - Gold" = X,
        codeunit "Customer Level - Silver" = X,
        codeunit "Resource Functions" = X,
        codeunit TrainingResourceSubscriptions = X,
        codeunit "Training Sales Subscriptions" = X,
        page "Execute Actions" = X,
        page "My Application Area" = X,
        page TrainingsAPI = X,
        query "Training Information" = X,
        report "Update Training Price" = X,
        xmlport Training = X,
        xmlport "Training Text" = X;
}