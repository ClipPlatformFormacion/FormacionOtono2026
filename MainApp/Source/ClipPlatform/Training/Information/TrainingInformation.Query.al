namespace ClipPlatform.Training.Information;

using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Resource;
query 50100 "Training Information"
{
    QueryType = Normal;

    elements
    {
        dataitem(Training; Training)  // FROM "Training"
        {
            DataItemTableFilter = "Duration (hours)" = filter('>0'); // where
            column(TrainingNo; "No.") // * --> select campo,campo,campo
            {

            }
            column(Name; Name)
            {
                // ColumnFilter = '<>Bla';
            }
            column(Duration__hours_; "Duration (hours)") { }
            filter(No__of_Sessions; "No. of Sessions")
            {

            }

            dataitem(Resource; Resource)
            {
                DataItemLink = "Training No." = Training."No."; // join on                

                column(ResourceNo; "No.") { }
                column(Base_Unit_of_Measure; "Base Unit of Measure") { }

                dataitem(Training_Edition; "Training Edition")
                {
                    dataItemLink = "Training No." = Training."No."; // join on

                    column(Edition; Edition) { }
                    column(Start_Date; "Start Date") { }
                    column(End_Date; "End Date") { }
                    column(Type__Enum_; "Type (Enum)") { }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}