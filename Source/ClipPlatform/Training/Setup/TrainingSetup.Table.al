namespace ClipPlatform.Training.Setup;

using Microsoft.Foundation.NoSeries;

table 50102 "Training Setup"
{
    Caption = 'Trainings Setup';
    DataClassification = CustomerContent;
    DrillDownPageID = "Training Setup";
    LookupPageID = "Training Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; "Training Nos."; Code[20])
        {
            Caption = 'Training Nos.';
            ToolTip = 'Specifies the number series code you can use to assign numbers to Trainings.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}