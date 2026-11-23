namespace ClipPlatform.Training.ImportExport;
using ClipPlatform.Training.MasterData;

xmlport 50101 "Training Text"
{
    Direction = Import;
    FormatEvaluate = Xml;
    Format = VariableText;
    // FieldSeparator = ';';
    // FieldDelimiter ='---';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Training; Training)
            {
                AutoSave = false;
                AutoUpdate = true;
                // AutoReplace = true;
                fieldelement(No; Training."No.") { }
                fieldelement(Name; Training.Name) { }
                fieldelement(Price; Training.Price) { }
                fieldelement(Duration; Training."Duration (hours)") { }
                textelement(Porcentaje)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        Training.Validate(Name, Training.Name + ' ' + Porcentaje);
                    end;
                }

                trigger OnAfterInitRecord()
                begin
                    // if SecumplenLasCondiciones then 
                    //     Training.Modify()
                    // else
                end;

                trigger OnBeforeInsertRecord()
                begin
                    if Training.Price < (Training."Duration (hours)" * 100) then
                        Error('Price is too low for the given duration.');
                end;

                trigger OnBeforeModifyRecord()
                begin
                    if Training.Price < (Training."Duration (hours)" * 100) then
                        Error('Price is too low for the given duration.');
                end;
            }
        }
    }
}