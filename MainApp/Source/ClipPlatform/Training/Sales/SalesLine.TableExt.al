namespace ClipPlatform.Training.Sales;

using ClipPlatform.Training.MasterData;
using Microsoft.Sales.Document;

tableextension 50102 "Sales Line" extends "Sales Line"
{
    fields
    {
        field(50100; "Training No."; Code[20])
        {
            Caption = 'Training No.', comment = 'ESP="Nº formación"';
            TableRelation = Training;
            DataClassification = CustomerContent;
        }
        field(50101; "Training Edition"; Code[20])
        {
            Caption = 'Training Edition', comment = 'ESP="Edición formación"';
            TableRelation = "Training Edition".Edition where("Training No." = field("Training No."));
            DataClassification = CustomerContent;
        }
    }
}