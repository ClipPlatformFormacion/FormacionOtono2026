namespace ClipPlatform.Training.ImportExport;
using ClipPlatform.Training.MasterData;

xmlport 50100 "Training"
{
    Direction = Export;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(Training; Training)
            {
                fieldattribute(Blocked; Training.Blocked)
                {

                }
                fieldelement(No; Training."No.") { }
                fieldelement(Name; Training.Name) { }
                fieldelement(Price; Training.Price) { }
                fieldelement(Duration; Training."Duration (hours)") { }
                tableelement(TrainingEditions; "Training Edition")
                {
                    LinkTable = Training;
                    LinkFields = "Training No." = field("No.");

                    fieldelement(Edition; TrainingEditions.Edition) { }
                    fieldelement(StartDate; TrainingEditions."Start Date") { }
                    // fieldelement(Type; TrainingEditions.Type) { }
                    textelement(Type)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            case TrainingEditions.Type of
                                TrainingEditions.Type::" ":
                                    Type := 'Blank';
                                TrainingEditions.Type::"Instructor-Lead":
                                    Type := 'Instructor-Lead';
                                TrainingEditions.Type::"Video Tutorial":
                                    Type := 'Video Tutorial';
                            end;
                        end;
                    }
                }
            }
        }
    }
}