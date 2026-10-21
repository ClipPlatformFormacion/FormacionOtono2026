permissionset 50100 "Super Training"
{
    CaptionML = ENU = 'SUPER Training', ESP = 'SUPER Formaciones';
    Assignable = true;
    Permissions = tabledata Training = RIMD,
        table Training = X,
        tabledata "Training Edition" = RIMD,
        page "Training List" = X,
        table "Training Edition" = X,
        page "Training Card" = X,
        page "Training Editions" = X,
        page "Training Editions Factbox" = X;
}