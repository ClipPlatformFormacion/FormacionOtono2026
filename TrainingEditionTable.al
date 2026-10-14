table 50101 "Training Edition"
{
    CaptionML = ENU = 'Training Edition', ESP = 'Edición formación';

    fields
    {
        field(1; "Training No."; Code[20])
        {
            CaptionML = ENU = 'Training No.', ESP = 'Nº formación';
            TableRelation = Training;
        }
        field(2; Edition; Code[20])
        {
            CaptionML = ENU = 'Edition', ESP = 'Edición';
        }
        field(3; "Start Date"; Date)
        {
            CaptionML = ENU = 'Start Date', ESP = 'Fecha inicio';
        }
        field(4; "End Date"; Date)
        {
            CaptionML = ENU = 'End Date', ESP = 'Fecha fin';
        }
        field(5; "Max. students"; Integer)
        {
            CaptionML = ENU = 'Max. Students', ESP = 'Máx. alumnos';
        }
    }

    keys
    {
        key(PK; "Training No.", Edition)
        {
            Clustered = true;
        }
    }
}