namespace ClipPlatform.Training.Permissions;

using ClipPlatform.Training.MasterData;
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
        page "Training Setup" = X;
}