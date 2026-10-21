table 50101 "Training Edition"
{
    CaptionML = ENU = 'Training Edition', ESP = 'Edición formación';

    fields
    {
        field(1; "Training No."; Code[20])
        {
            CaptionML = ENU = 'Training No.', ESP = 'Nº formación';
            TableRelation = Training;
            ToolTipML = ENU = 'Help', ESP = 'Un texto de ayuda';
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

            trigger OnValidate()
            var
                SelectTypeErr: TextConst ENU = 'Max. Students cannot be set if Type is not specified',
                                      ESP = 'No se puede especificar Máx. alumnos si no se establece el Tipo';
                MaxStudentsNotAllowedOnVideoTutorialErr: TextConst ENU = 'Cannot have Max. Students on a Video Tutorial',
                                                            ESP = 'No se pueden especificar Máx. alumnos para un Vídeo tutorial';
                UnknownTypeErr: TextConst ENU = 'Unknown Type %1', ESP = 'Tipo %1 desconocido';
            begin
                case Rec."Type (Enum)" of
                    Rec."Type (Enum)"::" ":
                        if Rec."Max. students" > 0 then
                            Error(SelectTypeErr);
                    Rec."Type (Enum)"::"Instructor-Lead":
                        ;
                    Rec."Type (Enum)"::"Video Tutorial":
                        if Rec."Max. students" <> 0 then
                            Error(MaxStudentsNotAllowedOnVideoTutorialErr);
                    else
                        Error(UnknownTypeErr);
                end;
            end;
        }
        field(6; Type; Option)
        {
            CaptionML = ENU = 'Type', ESP = 'Tipo';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            //                0,     1          ,        2         ,3,4;
            OptionCaptionML = ENU = ' ,Instructor-Lead,Video Tutorial', ESP = ' ,Guiado por profesor,Vídeo tutorial';
        }
        field(7; "Type (Enum)"; Enum "Edition Type")
        {
            CaptionML = ENU = 'Type (Enum)', ESP = 'Tipo (Enum)';
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