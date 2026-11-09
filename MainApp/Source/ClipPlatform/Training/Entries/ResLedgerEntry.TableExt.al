namespace ClipPlatform.Training.Entries;

using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Ledger;

tableextension 50108 "Res. Ledger Entry" extends "Res. Ledger Entry"
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