namespace ClipPlatform.Training.MasterData;

table 50101 "Training Edition"
{
    Caption = 'Training Edition', Comment = 'ESP="Edición formación';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Training No."; Code[20])
        {
            Caption = 'Training No.', Comment = 'ESP="Nº formación"';
            TableRelation = Training;
            ToolTip = 'Help', Comment = 'ESP="Un texto de ayuda"';
        }
        field(2; Edition; Code[20])
        {
            Caption = 'Edition', Comment = 'ESP="Edición"';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date', Comment = 'ESP="Fecha inicio"';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date', Comment = 'ESP="Fecha fin"';
        }
        field(5; "Max. students"; Integer)
        {
            Caption = 'Max. Students', Comment = 'ESP="Máx. alumnos"';

            trigger OnValidate()
            var
                SelectTypeErr: Label 'No se puede especificar Máx. alumnos si no se establece el Tipo', Comment = 'ESP="$3"';
                MaxStudentsNotAllowedOnVideoTutorialErr: Label 'No se pueden especificar Máx. alumnos para un Vídeo tutorial', Comment = 'ESP="$3"';
                UnknownTypeErr: Label 'Unknown type %1', Comment = 'ESP="Tipo %1 desconocido"';
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
            Caption = 'Type', Comment = 'ESP="Tipo"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            //                0,     1          ,        2         ,3,4;
            OptionCaption = ' ,Instructor-Lead,Video Tutorial', Comment = 'ESP=" ,Guiado por profesor,Vídeo tutorial"';
        }
        field(7; "Type (Enum)"; Enum "Edition Type")
        {
            Caption = 'Type (Enum)', Comment = 'ESP="Tipo (Enum)"';
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