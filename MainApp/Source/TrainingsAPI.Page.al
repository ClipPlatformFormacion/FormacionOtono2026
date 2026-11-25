page 50107 "TrainingsAPI"
{
    Caption = 'trainingsAPI';
    PageType = API;
    APIPublisher = 'clipplatform';
    APIGroup = 'trainingManagement';
    APIVersion = 'v1.0';
    EntityName = 'training';
    EntitySetName = 'trainings';
    SourceTable = Training;
    DelayedInsert = true;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field(no; Rec."No.") { NotBlank = true; }
                field(name; Rec.Name) { }
                field(price; Rec.Price) { Editable = false; }
                field(blocked; Rec.Blocked) { Editable = false; }
                field(durationHours; Rec."Duration (hours)") { }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Blocked := true;
    end;

    [ServiceEnabled]
    procedure NombreDeLaFuncion(var ActionContext: WebServiceActionContext)
    begin
        // Escribir aquí el código de lo que tiene que hacer esta acción

        ActionContext.SetObjectType(ObjectType::Table);
        ActionContext.SetObjectId(Database::Training);
        ActionContext.AddEntityKey(Rec.FieldNo("No."), Rec."No.");
        ActionContext.SetResultCode(WebServiceActionResultCode::Updated);
    end;

}